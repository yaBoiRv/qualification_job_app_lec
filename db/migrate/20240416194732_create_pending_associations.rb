# frozen_string_literal: true

class CreatePendingAssociations < ActiveRecord::Migration[7.1]
  def change
    create_table :pending_associations do |t|
      t.references :user, foreign_key: true
      t.references :calendar_group, foreign_key: true
      t.string :status, default: 'pending'
      t.timestamps
    end
  end
end
