# frozen_string_literal: true

class CalendarParticipant < ApplicationRecord
  belongs_to :calendar_participant_join_table
  has_many :participant_reservations
end
