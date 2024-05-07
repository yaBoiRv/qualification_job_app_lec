# frozen_string_literal: true

class HorseCoursesUser < ApplicationRecord
  belongs_to :user
  belongs_to :horse_course
end
