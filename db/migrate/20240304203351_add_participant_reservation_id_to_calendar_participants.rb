# frozen_string_literal: true

class AddParticipantReservationIdToCalendarParticipants < ActiveRecord::Migration[7.1]
  def change
    add_column :calendar_participants, :participant_reservation_id, :bigint
    add_index :calendar_participants, :participant_reservation_id
  end
end
