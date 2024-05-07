# frozen_string_literal: true

class AddCanvasImageToPonyCourses < ActiveRecord::Migration[7.1]
  def change
    add_column :pony_courses, :canvas_image, :binary
  end
end
