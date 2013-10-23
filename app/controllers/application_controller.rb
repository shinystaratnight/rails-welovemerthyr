class ApplicationController < ActionController::Base
  protect_from_forgery

  rescue_from CanCan::AccessDenied do |exception|
    logger.info "Error => #{exception.message}"
    redirect_to root_url, alert: exception.message
  end

  def after_sign_in_path_for(resource_or_scope)
    admin_pages_path
  end
end
