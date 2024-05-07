# frozen_string_literal: true

class CalendarHorse < ApplicationRecord
  belongs_to :calendar_group
  has_many :participant_reservations, through: :calendar_group
end
