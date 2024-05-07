# frozen_string_literal: true

class CreateCalendarGroups < ActiveRecord::Migration[7.1]
  def change
    create_table :calendar_groups do |t|
      t.references :admin, null: false, foreign_key: { to_table: :users }
      t.references :calendar_horse, foreign_key: true
      t.references :calendar_pony, foreign_key: true
      t.string :group_name

      t.timestamps
    end
  end
end
