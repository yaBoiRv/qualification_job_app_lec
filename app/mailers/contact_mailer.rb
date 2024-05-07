# frozen_string_literal: true

class ContactMailer < ApplicationMailer
  def send_support_email(name, email, message)
    @name = name
    @message = message
    @email = email
    mail(to: 'lecapp@inbox.lv', subject: 'Atblasta ziņa')
  end

  def send_confirmation_email(name, email)
    @name = name
    mail(to: email, subject: 'Apstiptinājums: jūsu ziņa ir nosūtīta veiksmīgi')
  end
end
