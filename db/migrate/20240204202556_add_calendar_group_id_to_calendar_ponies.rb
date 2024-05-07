# frozen_string_literal: true

class AddCalendarGroupIdToCalendarPonies < ActiveRecord::Migration[7.1]
  def change
    add_reference :calendar_ponies, :calendar_group, null: false, foreign_key: true
  end
end
