# frozen_string_literal: true

class CreateExercises < ActiveRecord::Migration[7.1]
  def change
    create_table :exercises do |t|
      t.references :user, null: false, foreign_key: true
      t.string :exercise_name
      t.text :exercise_description
      t.string :animal_type
      t.string :exercise_type
      t.boolean :public
      t.boolean :completed

      t.timestamps
    end
  end
end
