# frozen_string_literal: true

class CreateJoinTableParticipantReservationsCalendarPonies < ActiveRecord::Migration[7.1]
  def change
    create_join_table :participant_reservations, :calendar_ponies do |t|
      t.index %i[participant_reservation_id calendar_pony_id]
      t.index %i[calendar_pony_id participant_reservation_id]
    end
  end
end
