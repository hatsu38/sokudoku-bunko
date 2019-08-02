# frozen_string_literal: true

class ApplicationController < ActionController::Base
  rescue_from StandardError, with: :error_500
  rescue_from ActiveRecord::RecordNotFound, with: :error_404
  rescue_from ActionController::UnknownFormat, with: :error_404
  rescue_from ActionView::MissingTemplate, with: :error_404

  def error_500(exception = nil)
    message = '[server error] internal server error occured'
    message += exception ? "#{exception.class}: #{exception.message}\n#{exception.backtrace.join("\n")}" : ''
    logger.error(message)
    render template: 'errors/500', status: :internal_server_error
  end

  def error_404(exception = nil)
    message = '[Not found] , please check access url.'
    message += exception ? "#{exception.class}: #{exception.message}\n#{exception.backtrace.join("\n")}" : ''
    logger.error(message)
    render template: 'errors/404', status: :not_found, formats: :html
  end

  def error_403(exception = nil)
    message = '[Forbidden] Failed authenticate.'
    message += exception ? "#{exception.class}: #{exception.message}\n#{exception.backtrace.join("\n")}" : ''
    logger.error(message)
    render template: 'errors/403', status: :forbidden, formats: :html
  end
end
