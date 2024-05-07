# frozen_string_literal: true

# app/models/user.rb
class User < ApplicationRecord
  # ----calendar reservations
  has_many :calendar_participant_join_tables, dependent: :destroy
  has_many :calendar_groups, through: :calendar_participant_join_tables, dependent: :destroy
  has_many :exercises, dependent: :destroy
  has_many :pending_associations, dependent: :destroy
  #------related to all courses and exercises----------------
  has_many :pony_courses_users, dependent: :destroy
  has_many :pony_courses, through: :pony_courses_users, dependent: :destroy
  #--------------------------
  has_many :pony_exercises_users, dependent: :destroy
  has_many :pony_exercises, through: :pony_exercises_users, dependent: :destroy
  #--------------------------
  has_many :horse_courses_users, dependent: :destroy
  has_many :horse_courses, through: :horse_courses_users, dependent: :destroy
  #--------------------------
  has_many :horse_exercises_users, dependent: :destroy
  has_many :horse_exercises, through: :horse_exercises_users, dependent: :destroy
  #--------validations-----------------
  has_secure_password
  validates :name, presence: true
  validates :surname, presence: true

  validates :username, uniqueness: true, if: :username_changed?
  validates :email, presence: true, uniqueness: true, if: :email_changed?

  validates :password, presence: true, length: { minimum: 8 }, if: :password_required?
  validates :password_confirmation, presence: true, if: :password_required?
  mount_uploader :avatar, AvatarUploader
  validate :avatar_content_type

  private

  def password_required?
    new_record? || password.present? || password_confirmation.present?
  end

  def avatar_content_type
    return unless avatar.present?

    return if avatar.content_type.in?(%w[image/jpeg image/png])

    errors.add('Failām jābūt png vai jpeg formātā!')
  end
end
