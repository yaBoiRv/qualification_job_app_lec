# frozen_string_literal: true

class PonyCoursesUser < ApplicationRecord
  belongs_to :user
  belongs_to :pony_course
end
