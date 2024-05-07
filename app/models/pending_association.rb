# frozen_string_literal: true

class PendingAssociation < ApplicationRecord
  belongs_to :user
  belongs_to :calendar_group
end
