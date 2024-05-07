# frozen_string_literal: true

class HorseExercise < ApplicationRecord
  has_many :horse_exercises_users, dependent: :destroy
  has_many :users, through: :horse_exercises_users
  belongs_to :exercise
end
