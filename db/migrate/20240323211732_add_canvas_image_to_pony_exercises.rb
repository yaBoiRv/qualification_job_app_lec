# frozen_string_literal: true

class AddCanvasImageToPonyExercises < ActiveRecord::Migration[7.1]
  def change
    add_column :pony_exercises, :canvas_image, :binary
  end
end
