# frozen_string_literal: true

class ParticipantReservationsController < ApplicationController
  before_action :set_calendar_group
  before_action :set_calendar_participant_join_table

  def index
    @reservations = @calendar_group.participant_reservations.order(date: :asc, time_from: :asc)
    render json: @reservations
  end

  def show
    @calendar_group = CalendarGroup.find(params[:calendar_group_id])
    @reservations = @calendar_group.participant_reservations
  end

  def new
    @calendar_group = CalendarGroup.find(params[:calendar_group_id])
  end

  def edit
    @calendar_group = CalendarGroup.find(params[:calendar_group_id])
    @reservation = @calendar_participant_join_table.participant_reservations.find(params[:id])
  end

  def create
    params[:current_user_id]
    @reservation = @calendar_participant_join_table.participant_reservations.new(reservation_params)
    @reservation.calendar_group_id = params[:calendar_group_id]
    if params[:participant_reservation][:calendar_horse_ids].present?
      @reservation.calendar_horse_ids = params[:participant_reservation][:calendar_horse_ids].reject(&:empty?)
    end
    @reservation.created_by_id = current_user.id
    if params[:participant_reservation][:calendar_pony_ids].present?
      @reservation.calendar_pony_ids = params[:participant_reservation][:calendar_pony_ids].reject(&:empty?)
    end
    if !@calendar_group.parallel_reservation
      if check_reservation_overlap(@reservation) && @reservation.save
        redirect_to @calendar_group, notice: 'Rezervācija veiksmīgi izveidota'
      else
        redirect_to @calendar_group, alert: 'Rezervācija pārklājās'
      end
    elsif check_reservation_overlap_allow_different_horse_pony(@reservation) && @reservation.save
      redirect_to @calendar_group, notice: 'Rezervācija veiksmīgi izveidota'
    else
      redirect_to @calendar_group, alert: 'Nevar izveidot rezervāciju, jo tas pats zirgs/ponijs jau ir izvēlēts.'
    end
  end

  def update
    params[:current_user_id]
    @reservation = ParticipantReservation.find(params[:id])

    # Wrap the update operation inside a transaction block
    ParticipantReservation.transaction do
      if !@calendar_group.parallel_reservation
        if check_reservation_overlap(@reservation) && @reservation.update(reservation_params)
          redirect_to @calendar_group, notice: 'Rezervācija veiksmīgi atjaunināta'
        else
          redirect_to @calendar_group, alert: 'Rezervācija pārklājās'
          raise ActiveRecord::Rollback # Roll back the transaction
        end
      elsif @reservation.update(reservation_params) && check_reservation_overlap_allow_different_horse_pony(@reservation)
        redirect_to @calendar_group, notice: 'Rezervācija veiksmīgi atjaunināta'
      else
        redirect_to @calendar_group, alert: 'Nevar atjaunināt rezervāciju, jo tas pats zirgs/ponijs jau ir izvēlēts.'
        raise ActiveRecord::Rollback # Roll back the transaction
      end
    end
  end

  def destroy
    @reservation = @calendar_participant_join_table.participant_reservations.find(params[:id])
    if @reservation.destroy
      redirect_to @calendar_group, notice: 'Rezervācija veiksmīgi dzēsta!'
    else
      redirect_to @calendar_group, alert: 'Neizdevās dzēst rezervāciju!'
    end
  end

  private

  def check_reservation_overlap(reservation)
    overlapping_reservations = ParticipantReservation.where(calendar_group_id: reservation.calendar_group_id)
                                                     .where.not(id: reservation.id) # Exclude the current reservation if it's being updated
                                                     .where('(date = ? AND ((time_from <= ? AND time_to >= ?) OR (time_from <= ? AND time_to >= ?) OR (time_from >= ? AND time_to <= ?)))',
                                                            reservation.date,
                                                            reservation.time_from,
                                                            reservation.time_from,
                                                            reservation.time_to,
                                                            reservation.time_to,
                                                            reservation.time_from,
                                                            reservation.time_to)
    return false if overlapping_reservations.any?

    true
  end

  def check_reservation_overlap_allow_different_horse_pony(reservation)
    overlapping_reservations = ParticipantReservation.where(calendar_group_id: reservation.calendar_group_id)
                                                     .where.not(id: reservation.id) # Exclude the current reservation if it's being updated
                                                     .where(date: reservation.date)
                                                     .where('(time_from < ? AND time_to > ?) OR (time_from > ? AND time_from < ?) OR (time_to > ? AND time_to < ?)',
                                                            reservation.time_to,
                                                            reservation.time_from,
                                                            reservation.time_from,
                                                            reservation.time_to,
                                                            reservation.time_from,
                                                            reservation.time_to)

    overlapping_reservations.each do |r|
      if (reservation.calendar_horse_ids & r.calendar_horse_ids).any? || (reservation.calendar_pony_ids & r.calendar_pony_ids).any?
        return false
      end
    end

    true
  end

  def set_calendar_group
    @calendar_group = CalendarGroup.find(params[:calendar_group_id])
  end

  def set_calendar_participant_join_table
    @calendar_participant_join_table = CalendarParticipantJoinTable.find_or_create_by(user: current_user,
                                                                                      calendar_group: @calendar_group)
  end

  def reservation_params
    params.require(:participant_reservation).permit(:date, :time_from, :time_to, :comments, :calendar_group_id,
                                                    :calendar_participant_join_table_id, calendar_pony_ids: [], calendar_horse_ids: [])
  end
end
