# frozen_string_literal: true

class AddCalendarParticipantJoinTableToParticipantReservations < ActiveRecord::Migration[7.1]
  def change
    add_reference :participant_reservations, :calendar_participant_join_table, null: false, foreign_key: true
    remove_column :participant_reservations, :calendar_participant_id, :bigint
  end
end
