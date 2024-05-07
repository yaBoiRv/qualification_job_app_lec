# frozen_string_literal: true

class AddExerciseIdToHorseCourses < ActiveRecord::Migration[7.1]
  def change
    add_reference :horse_courses, :exercise, foreign_key: true, null: true
  end
end
