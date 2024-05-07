# frozen_string_literal: true

class ParticipantReservation < ApplicationRecord
  belongs_to :calendar_participant_join_table
  belongs_to :user, optional: true
  belongs_to :calendar_group, optional: true
  has_and_belongs_to_many :calendar_horses, optional: true
  has_and_belongs_to_many :calendar_ponies, optional: true

  def start_time
    date.to_time + time_from.seconds_since_midnight.seconds
  end

  def end_time
    date.to_time + time_to.seconds_since_midnight.seconds
  end
end
