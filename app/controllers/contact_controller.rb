# frozen_string_literal: true

class ContactController < ApplicationController
  def index; end

  def support
    name = params[:name]
    email = params[:email]
    message = params[:message]
    ContactMailer.send_support_email(name, email, message).deliver_now
    ContactMailer.send_confirmation_email(name, email).deliver_now
    redirect_to contact_index_path,
                notice: 'Paldies! Apstiprinājums ir nosūtīts uz jūsu e-past ar jums drīzumā sazināsies.', flash: { timeout: 10_000 }
  end
end
