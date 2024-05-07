# frozen_string_literal: true

class CreateCalendarParticipants < ActiveRecord::Migration[7.1]
  def change
    create_table :calendar_participants do |t|
      t.references :calendar_participant_join_table, foreign_key: true

      t.timestamps
    end
  end
end
