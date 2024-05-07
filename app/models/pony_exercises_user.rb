# frozen_string_literal: true

class PonyExercisesUser < ApplicationRecord
  belongs_to :user
  belongs_to :pony_exercise
end
