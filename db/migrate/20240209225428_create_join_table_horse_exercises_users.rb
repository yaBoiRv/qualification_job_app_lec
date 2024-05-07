# frozen_string_literal: true

class CreateJoinTableHorseExercisesUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :horse_exercises_users do |t|
      t.references :user, null: false, foreign_key: true
      t.references :horse_exercise, null: false, foreign_key: true
      t.boolean :used, default: false
      t.boolean :saved, default: false

      t.timestamps
    end
  end
end
