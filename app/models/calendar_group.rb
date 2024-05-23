# frozen_string_literal: true

class CalendarGroup < ApplicationRecord
  has_many :calendar_horses, dependent: :destroy
  has_many :calendar_ponies, dependent: :destroy
  has_many :participant_reservations, dependent: :destroy
  has_many :calendar_participant_join_tables, dependent: :destroy
  has_many :pending_associations, dependent: :destroy
  has_many :users, through: :calendar_participant_join_tables, validate: false

  accepts_nested_attributes_for :calendar_horses, allow_destroy: true
  accepts_nested_attributes_for :calendar_ponies, allow_destroy: true

  validates :group_name, presence: true, uniqueness: { scope: :admin_id }
end
