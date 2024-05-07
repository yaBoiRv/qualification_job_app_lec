# frozen_string_literal: true

class CreateJoinTableParticipantReservationsCalendarHorses < ActiveRecord::Migration[7.1]
  def change
    create_join_table :participant_reservations, :calendar_horses do |t|
      t.index %i[participant_reservation_id calendar_horse_id]
      t.index %i[calendar_horse_id participant_reservation_id]
    end
  end
end
