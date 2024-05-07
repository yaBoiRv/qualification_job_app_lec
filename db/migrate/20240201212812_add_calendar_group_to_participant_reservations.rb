# frozen_string_literal: true

class AddCalendarGroupToParticipantReservations < ActiveRecord::Migration[7.1]
  def change
    add_reference :participant_reservations, :calendar_group, null: false, foreign_key: true
  end
end
