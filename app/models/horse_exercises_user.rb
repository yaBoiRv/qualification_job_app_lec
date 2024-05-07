# frozen_string_literal: true

class HorseExercisesUser < ApplicationRecord
  belongs_to :user
  belongs_to :horse_exercise
  has_one_attached :canvas_image
end
