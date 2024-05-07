# frozen_string_literal: true

class AddCreatedByToParticipantReservations < ActiveRecord::Migration[7.1]
  def change
    add_column :participant_reservations, :created_by_id, :bigint
  end
end
