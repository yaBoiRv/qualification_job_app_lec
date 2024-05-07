# frozen_string_literal: true

class AddExerciseIdToPonyCourses < ActiveRecord::Migration[7.1]
  def change
    add_reference :pony_courses, :exercise, foreign_key: true, null: true
  end
end
