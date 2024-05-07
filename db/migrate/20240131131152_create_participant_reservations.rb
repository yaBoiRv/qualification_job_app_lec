# frozen_string_literal: true

class CreateParticipantReservations < ActiveRecord::Migration[7.1]
  def change
    create_table :participant_reservations do |t|
      t.references :calendar_participant, foreign_key: true
      t.references :calendar_pony, foreign_key: true
      t.references :calendar_horse, foreign_key: true
      t.date :date
      t.time :time_from
      t.time :time_to
      t.text :comments

      t.timestamps
    end
  end
end
