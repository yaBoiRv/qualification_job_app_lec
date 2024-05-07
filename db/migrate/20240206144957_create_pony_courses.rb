# frozen_string_literal: true

class CreatePonyCourses < ActiveRecord::Migration[7.1]
  def change
    create_table :pony_courses do |t|
      t.string :title
      t.text :description

      t.timestamps
    end
  end
end
