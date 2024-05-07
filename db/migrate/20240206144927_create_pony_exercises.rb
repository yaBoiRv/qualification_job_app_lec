# frozen_string_literal: true

class CreatePonyExercises < ActiveRecord::Migration[7.1]
  def change
    create_table :pony_exercises do |t|
      t.string :title
      t.text :description

      t.timestamps
    end
  end
end
