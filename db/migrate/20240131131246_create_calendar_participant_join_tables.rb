# frozen_string_literal: true

class CreateCalendarParticipantJoinTables < ActiveRecord::Migration[7.1]
  def change
    create_table :calendar_participant_join_tables do |t|
      t.references :calendar_group, foreign_key: true
      t.references :user, foreign_key: true
    end
  end
end
