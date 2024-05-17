# frozen_string_literal: true

class Exercise < ApplicationRecord
  belongs_to :user
  has_many :horse_courses, dependent: :destroy
  has_many :horse_exercises, dependent: :destroy
  has_many :pony_courses, dependent: :destroy
  has_many :pony_exercises, dependent: :destroy
  enum exercise_type: { marsruts: 'maršruts', vingrinajums: 'vingrinājums' }
  validates :animal_type, inclusion: { in: %w[Ponijs Zirgs] }
  validates :exercise_name, presence: true, uniqueness: true
  validates :exercise_description, presence: true
end
