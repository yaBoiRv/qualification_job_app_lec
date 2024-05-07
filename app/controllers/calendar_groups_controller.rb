# frozen_string_literal: true

class CalendarGroupsController < ApplicationController
  before_action :set_calendar_group, only: %i[show edit update destroy]
  helper_method :admin?

  def index
    user_calendar_groups = current_user.calendar_groups
    admin_calendar_groups = CalendarGroup.where(admin_id: current_user.id)

    ordered_user_calendar_groups = user_calendar_groups.order(created_at: :desc)
    ordered_admin_calendar_groups = admin_calendar_groups.order(created_at: :desc)

    combined_calendar_groups = (ordered_user_calendar_groups + ordered_admin_calendar_groups).uniq

    @calendar_groups = Kaminari.paginate_array(combined_calendar_groups).page(params[:page]).per(5)
  end

  def show
    @calendar_group = CalendarGroup.find(params[:id])
    @reservations = @calendar_group.participant_reservations
  end

  def new
    @calendar_group = CalendarGroup.new
    @calendar_group.calendar_horses.build
    @calendar_group.calendar_ponies.build
    @pony = CalendarPony.new
    @horse = CalendarHorse.new
  end

  def edit; end

  def create
    params[:current_user_id]
    @calendar_group = CalendarGroup.new(calendar_group_params)
    @calendar_group.admin_id = current_user.id

    @calendar_group.calendar_horses = @calendar_group.calendar_horses.reject { |horse| horse.horse_name.blank? }
    @calendar_group.calendar_ponies = @calendar_group.calendar_ponies.reject { |pony| pony.pony_name.blank? }
    @calendar_group.user_ids
    @calendar_group.user_ids = []
    associate_users
    if @calendar_group.save
      @calendar_group.calendar_participant_join_tables.create(user_id: current_user.id)

      redirect_to @calendar_group, notice: 'Kalendāra grupa veiksmīgi izveidota!'
    else
      render :new
    end
  end

  def update
    if @calendar_group.calendar_horses.present?
      @calendar_group.calendar_horses = @calendar_group.calendar_horses.reject do |horse|
        horse.horse_name.blank?
      end
    end
    if @calendar_group.calendar_ponies.present?
      @calendar_group.calendar_ponies = @calendar_group.calendar_ponies.reject do |pony|
        pony.pony_name.blank?
      end
    end

    original_horse_ids = @calendar_group.calendar_horses.pluck(:id) if @calendar_group.calendar_horses.present?
    original_pony_ids = @calendar_group.calendar_ponies.pluck(:id) if @calendar_group.calendar_ponies.present?

    updated_calendar_group_params = calendar_group_params

    if updated_calendar_group_params[:calendar_horses_attributes].present?
      updated_calendar_group_params[:calendar_horses_attributes] =
        updated_calendar_group_params[:calendar_horses_attributes].reject { |_, horse| horse[:horse_name].blank? }
    end
    if updated_calendar_group_params[:calendar_ponies_attributes].present?
      updated_calendar_group_params[:calendar_ponies_attributes] =
        updated_calendar_group_params[:calendar_ponies_attributes].reject { |_, pony| pony[:pony_name].blank? }
    end

    if @calendar_group.update(updated_calendar_group_params)
      associate_users
      redirect_to @calendar_group, notice: 'Kalendāra grupa veiksmīgi atjaunināta.'
    else
      if @calendar_group.calendar_horses.present?
        @calendar_group.calendar_horses = CalendarHorse.where(id: original_horse_ids)
      end
      if @calendar_group.calendar_ponies.present?
        @calendar_group.calendar_ponies = CalendarPony.where(id: original_pony_ids)
      end
      render :edit
    end
  end

  def destroy
    @calendar_group.participant_reservations.destroy_all
    @calendar_group.calendar_horses.destroy_all
    @calendar_group.calendar_ponies.destroy_all
    @calendar_group.calendar_participant_join_tables.destroy_all
    @calendar_group.destroy

    if @calendar_group.destroyed?
      redirect_to calendar_groups_url, notice: 'Kalendāra grupa veiksmīgi dzēsta!'
    else
      redirect_to @calendar_group, alert: 'Neizdevās dzēst kalendāra grupu.'
    end
  end

  def remove_user
    calendar_group = CalendarGroup.find(params[:calendar_group_id])
    user = User.find(params[:user_id])
    calendar_group.users.delete(user)
    head :ok
  end

  private

  def admin?
    current_user.id == @calendar_group.admin_id
  end

  def set_calendar_group
    @calendar_group = CalendarGroup.find(params[:id])
  end

  def associate_users
    user_ids = params[:calendar_group][:user_ids]
    puts "User IDs: #{user_ids.inspect}"
    return unless user_ids

    user_ids = user_ids.join(',') if user_ids.is_a?(Array)
    user_ids.split(',').map(&:to_i).reject(&:zero?).each do |user_id|
      user = User.find_by(id: user_id)
      next unless user

      PendingAssociation.create(user:, calendar_group: @calendar_group) unless @calendar_group.users.include?(user)
    end
  end

  def accept_request
    pending_association = PendingAssociation.find(params[:pending_association_id])
    pending_association.update(status: 'accepted')
    @calendar_group.users << pending_association.user
    redirect_back(fallback_location: root_path)
  end

  def send_request
    user = User.find(params[:user_id])
    PendingAssociation.create(user:, calendar_group: @calendar_group)
    redirect_back(fallback_location: root_path)
  end

  def calendar_group_params
    params.require(:calendar_group).permit(
      :parallel_reservation,
      :group_name,
      calendar_horses_attributes: %i[id horse_name description _destroy],
      calendar_ponies_attributes: %i[id pony_name description _destroy],
      user_ids: []
    )
  end
end
