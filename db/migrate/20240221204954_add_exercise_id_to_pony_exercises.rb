# frozen_string_literal: true

class AddExerciseIdToPonyExercises < ActiveRecord::Migration[7.1]
  def change
    add_reference :pony_exercises, :exercise, foreign_key: true, null: true
  end
end
