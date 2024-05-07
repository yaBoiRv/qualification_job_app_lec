# frozen_string_literal: true

class AddForeignKeyConstraintToParticipantReservations < ActiveRecord::Migration[7.1]
  def change
    add_foreign_key :participant_reservations, :calendar_participant_join_tables, on_delete: :cascade
  end
end
