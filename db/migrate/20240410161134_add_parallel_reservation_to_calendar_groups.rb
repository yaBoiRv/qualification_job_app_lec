# frozen_string_literal: true

class AddParallelReservationToCalendarGroups < ActiveRecord::Migration[7.1]
  def change
    add_column :calendar_groups, :parallel_reservation, :boolean, default: false
  end
end
