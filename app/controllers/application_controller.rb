# frozen_string_literal: true

class ApplicationController < ActionController::Base # rubocop:disable Style/Documentation
  helper_method :current_user, :user_signed_in?
  before_action :set_locale
  before_action :check_session_expiry

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def user_signed_in?
    !current_user.nil?
  end

  private

  def check_session_expiry
    return unless session[:expires_at] && session[:expires_at] < Time.now

    reset_session
    flash[:alert] = 'Jūsu sesija ir beigusies!'
    redirect_to login_path
  end

  def set_locale
    I18n.locale = :lv
  end
end
