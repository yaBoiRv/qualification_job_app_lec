# frozen_string_literal: true

class CalendarPony < ApplicationRecord
  belongs_to :calendar_group
  has_many :participant_reservations, through: :calendar_group
end
