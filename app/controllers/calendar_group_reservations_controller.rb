# frozen_string_literal: true

class CalendarGroupReservationsController < ApplicationController
  before_action :set_calendar_group

  def index
    @reservations = @calendar_group.participant_reservations.order(date: :asc, time_from: :asc)

    events = @reservations.map do |reservation|

      {
        username: User.find_by(id: reservation.created_by_id)&.username || 'Neeksitējošs lietotājs',
        created_by_id: reservation.created_by_id,
        reservation_id: reservation.id,
        calendar_group_id: reservation.calendar_group_id,
        calendar_participant_join_table_id: reservation.calendar_participant_join_table_id,
        start: reservation.date.strftime('%Y-%m-%dT%H:%M:%S'),
        end: reservation.date.strftime('%Y-%m-%dT%H:%M:%S'),
        real_date: reservation.date,
        date: reservation.date.strftime('%d.%m.%Y'),
        formatted_date: reservation.date.strftime('%d.%m.%Y').to_s,
        start_time: reservation.time_from.strftime('%H:%M').to_s,
        end_time: reservation.time_to.strftime('%H:%M').to_s,
        comments: reservation.comments,
        time_description: "#{reservation.time_from.strftime('%H:%M')} - #{reservation.time_to.strftime('%H:%M')}\n",
        horses: reservation.calendar_horses.map(&:horse_name),
        ponies: reservation.calendar_ponies.map(&:pony_name),
        horses_ids: reservation.calendar_horses.map(&:id),
        ponies_ids: reservation.calendar_ponies.map(&:id)
      }
    end

    render json: events
  end

  private

  def set_calendar_group
    @calendar_group = CalendarGroup.find(params[:calendar_group_id])
  end
end
