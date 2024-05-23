# frozen_string_literal: true

class SessionsController < ApplicationController
  def create
    session[:user_id] = @user.id
    session[:expires_at] = 6.hours.from_now
  end

  def destroy
    session[:user_id] = nil
    session[:expires_at] = nil
    redirect_to welcome_page_url
  end
end
