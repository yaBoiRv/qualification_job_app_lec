# frozen_string_literal: true

class CreateHorseExercises < ActiveRecord::Migration[7.1]
  def change
    create_table :horse_exercises do |t|
      t.string :title
      t.text :description

      t.timestamps
    end
  end
end
