# frozen_string_literal: true

class PonyCourse < ApplicationRecord
  has_many :pony_courses_users, dependent: :destroy
  has_many :users, through: :pony_courses_users
  belongs_to :exercise
end
