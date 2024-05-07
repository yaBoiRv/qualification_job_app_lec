# frozen_string_literal: true

class CreateJoinTablePoniesCoursesUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :pony_courses_users do |t|
      t.references :user, null: false, foreign_key: true
      t.references :pony_course, null: false, foreign_key: true
      t.boolean :used, default: false
      t.boolean :saved, default: false

      t.timestamps
    end
  end
end
