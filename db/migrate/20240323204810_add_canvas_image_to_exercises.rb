# frozen_string_literal: true

class AddCanvasImageToExercises < ActiveRecord::Migration[7.1]
  def change
    add_column :exercises, :canvas_image, :bytea
  end
end
