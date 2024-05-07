# frozen_string_literal: true

class CreateCalendarPonies < ActiveRecord::Migration[7.1]
  def change
    create_table :calendar_ponies do |t|
      t.string :pony_name
      t.string :description

      t.timestamps
    end
  end
end
