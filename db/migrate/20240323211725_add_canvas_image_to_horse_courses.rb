# frozen_string_literal: true

class AddCanvasImageToHorseCourses < ActiveRecord::Migration[7.1]
  def change
    add_column :horse_courses, :canvas_image, :binary
  end
end
