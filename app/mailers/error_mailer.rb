# frozen_string_literal: true

class ErrorMailer < ActionMailer::Base
  def error_mail(exception, message)
    @exception = exception
    @message = message
    mail(
      to: Rails.application.credentials.admin_info[:email],
      from: Rails.application.credentials.admin_info[:email],
      subject: "[#{Rails.env}] [そくどく文庫-error] #{exception.message.slice(0..200)}"
    )
  end
end
