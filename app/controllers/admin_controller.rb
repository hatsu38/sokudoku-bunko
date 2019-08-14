# frozen_string_literal: true

class AdminController < ActionController::Base
  layout 'admin'
  before_action :authenticate_user!, :require_admin unless Rails.env.development?

  private

  def require_admin
    redirect_to new_user_session_path unless current_user.admin?
  end
end
