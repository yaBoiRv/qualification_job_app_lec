# frozen_string_literal: true

class CreateCalendarHorses < ActiveRecord::Migration[7.1]
  def change
    create_table :calendar_horses do |t|
      t.string :horse_name
      t.string :description

      t.timestamps
    end
  end
end
