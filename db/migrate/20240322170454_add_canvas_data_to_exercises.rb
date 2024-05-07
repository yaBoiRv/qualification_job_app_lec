# frozen_string_literal: true

class AddCanvasDataToExercises < ActiveRecord::Migration[7.1]
  def change
    add_column :exercises, :canvas_data, :text
  end
end
