# frozen_string_literal: true

class AddCalendarGroupIdToCalendarHorses < ActiveRecord::Migration[7.1]
  def change
    add_reference :calendar_horses, :calendar_group, null: false, foreign_key: true
  end
end
