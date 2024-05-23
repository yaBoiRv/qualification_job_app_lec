# frozen_string_literal: true

# app/controllers/users_controller.rb
class UsersController < ApplicationController
  before_action :set_user, only: [:update_password]
  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def login
    @user = User.new
  end

  def profile
    @user = current_user
  end

  def create
    @user = User.new(user_params)
    respond_to do |format|
      if @user.save
        create_calendar_group(@user)
        format.html do
          redirect_to login_path, notice: t('user_created')
        end
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json do
          render json: @user.errors,
                 status: :unprocessable_entity
        end
      end
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to profile_path, notice: 'Jūsu profils ir veiksmīgi atjaunināts'
    else
      render :profile
    end
  end

  def logout
    session[:user_id] = nil
    redirect_to welcome_page_url, notice: t('logged_out')
  end

  def authenticate
    @user = User.find_by(username: params[:username])
    if !params[:username].blank? || !params[:password].blank?
      if @user&.authenticate(params[:password])
        session[:user_id] = @user.id
        redirect_to welcome_page_url, notice: t('logged_in', name: @user.name)
      else
        @user ||= User.new(username: params[:username])
        @user.errors.add(:base, 'Nederīgs lietotājvārds vai parole!')
        render :login
      end
    else
      @user ||= User.new(username: params[:username])
      @user.errors.add(:base, 'Lauki nevar būt tukši!')
      render :login
    end
  end

  def destroy
    @user = User.find(params[:id])
    # Find calendar groups where the user is an admin
    admin_groups = CalendarGroup.where(admin_id: @user.id)

    # Iterate over each admin group
    admin_groups.each do |group|
      # Find participant reservations associated with this group
      reservations = ParticipantReservation.where(calendar_group_id: group.id)

      # If the admin group has only one participant reservation,
      # delete the calendar group
      if reservations.count <= 1
        group.destroy
      else
        # If there are other participants, transfer admin role
        # to the first participant
        first_participant = reservations.first
        group.update(admin_id: first_participant.created_by_id)
      end
    end
    if @user.destroy
      redirect_to welcome_page_url, notice: 'Jūsu profils ir veiksmīgi dzēsts!'
    else
      redirect_to welcome_page_url, error: 'Radās kļūda dzēšot profilu!'
    end
  end

  def search
    term = params[:term]
    if !term.blank?
      @users = User.where('username LIKE ?', "%#{term}%").limit(6)
      if @users.blank?
        render json: { error: 'Nav atrasts neviens lietotājs' }
      else
        render json: { users: @users }
      end
    else
      render json: { error: 'Ievadiet lietotājvārdu' }
    end
  end

  def update_password
    if @user.authenticate(params[:user][:previous_password])
      if password_present?
        if @user.update(user_params)
          redirect_to profile_path, notice: 'Parole atjaunināta'
        else
          render :profile
        end
      else
        @user.errors.add(:password, 'Jaunā parole un atkārotā nevar būt tukša')
        render :profile
      end
    else
      @user.errors.add(:password, 'Esošā parole nav pareiza')
      render :profile
    end
  end

  private

  def password_present?
    params[:user][:password].present? && params[:user][:password_confirmation].present?
  end

  def set_user
    @user = current_user
  end

  def password_params
    params.require(:user).permit(:password, :password_confirmation, :previous_password)
  end

  def create_calendar_group(user)
    @calendar_group = CalendarGroup.new(admin_id: user.id)
    @calendar_group.group_name = "#{user.username} kalendāra grupa"
    @calendar_group.users << user
    @calendar_group.save
  end

  def error_message
    if @user.errors.any?
      @user.errors.full_messages.join(', ')
    else
      'An unknown error occurred.'
    end
  end

  def user_params
    params.require(:user).permit(:name, :surname, :username, :email, :password, :password_confirmation, :avatar)
  end
end
