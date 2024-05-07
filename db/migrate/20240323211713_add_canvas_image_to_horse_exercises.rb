# frozen_string_literal: true

class AddCanvasImageToHorseExercises < ActiveRecord::Migration[7.1]
  def change
    add_column :horse_exercises, :canvas_image, :binary
  end
end
