# frozen_string_literal: true

class PonyExercise < ApplicationRecord
  has_many :pony_exercises_users, dependent: :destroy
  has_many :users, through: :pony_exercises_users
  belongs_to :exercise
end
