# frozen_string_literal: true

class HorseCourse < ApplicationRecord
  has_many :horse_courses_users, dependent: :destroy
  has_many :users, through: :horse_courses_users
  belongs_to :exercise
end
