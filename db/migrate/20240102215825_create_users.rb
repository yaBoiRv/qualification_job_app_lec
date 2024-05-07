# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :surname
      t.string :username
      t.string :email
      t.string :password_digest
      t.string :avatar

      t.timestamps
    end
  end
end
