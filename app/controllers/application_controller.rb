# frozen_string_literal: true

class ApplicationController < ActionController::Base
  rescue_from StandardError, with: :error_500
  rescue_from ActiveRecord::RecordNotFound, with: :error_404
  rescue_from ActionController::UnknownFormat, with: :error_404
  rescue_from ActionView::MissingTemplate, with: :error_404

  def error_500(e)
    logger.error("[server error] internal server error occured #{e.class}: #{e.message}\n#{e.backtrace.join("\n")}")
    render template: 'errors/500', status: :internal_server_error
  end

  def error_404
    render template: 'errors/404', status: :not_found,  formats: :html
  end

  def error_403
    render template: 'errors/403', status: :forbidden,  formats: :html
  end
end
