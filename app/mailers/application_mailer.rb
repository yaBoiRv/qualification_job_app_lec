# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'lecapp@inbox.lv'
  layout 'mailer'
end
