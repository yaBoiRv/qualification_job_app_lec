# frozen_string_literal: true

class Exercise < ApplicationRecord
  belongs_to :user
  has_many :horse_courses
  has_many :horse_exercises
  has_many :pony_courses
  has_many :pony_exercises
  enum exercise_type: { marsuts: 'maršuts', vingrinajums: 'vingrinājums' }
  validates :animal_type, inclusion: { in: %w[Ponijs Zirgs] }
  validates :exercise_name, presence: true, uniqueness: true
  validates :exercise_description, presence: true
end
