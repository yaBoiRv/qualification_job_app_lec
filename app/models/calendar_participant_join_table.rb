# frozen_string_literal: true

class CalendarParticipantJoinTable < ApplicationRecord
  belongs_to :user
  belongs_to :calendar_group
  has_many :participant_reservations, dependent: :destroy
end
