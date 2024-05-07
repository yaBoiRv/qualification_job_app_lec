# frozen_string_literal: true

class AddExerciseIdToHorseExercises < ActiveRecord::Migration[7.1]
  def change
    add_reference :horse_exercises, :exercise, foreign_key: true, null: true
  end
end
