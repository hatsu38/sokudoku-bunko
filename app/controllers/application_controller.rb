# frozen_string_literal: true

class ApplicationController < ActionController::Base
  if Rails.env.production?
    rescue_from StandardError, with: :error_500
    rescue_from ActiveRecord::RecordNotFound, with: :error_404
    rescue_from ActionController::UnknownFormat, with: :error_404
    rescue_from ActionView::MissingTemplate, with: :error_404
  end

  def error_500(exception = nil)
    message = '[server error] internal server error occured'
    message += exception ? "#{exception.class}: #{exception.message}\n#{exception.backtrace.join("\n")}" : ''
    logger.error(message)
    send_error_mail(exception, message)
    render 'errors/500', status: :internal_server_error
  end

  def error_404(exception = nil)
    message = '[Not found] , please check access url.'
    message += exception ? "#{exception.class}: #{exception.message}\n#{exception.backtrace.join("\n")}" : ''
    logger.error(message)
    send_error_mail(exception, message) if exception.present?
    render 'errors/404', status: :not_found, formats: :html
  end

  def error_403(exception = nil)
    message = '[Forbidden] Failed authenticate.'
    message += exception ? "#{exception.class}: #{exception.message}\n#{exception.backtrace.join("\n")}" : ''
    logger.error(message)
    send_error_mail(exception, message) if exception.present?
    render 'errors/403', status: :forbidden, formats: :html
  end

  private

  # エラー専用メールアドレスへのメール通知
  def send_error_mail(exception, message)
    ErrorMailer.error_mail(exception, message).deliver_now
  end
end
