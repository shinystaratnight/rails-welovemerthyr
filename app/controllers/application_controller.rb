class ApplicationController < ActionController::Base
  protect_from_forgery

  rescue_from Exception, with: :exception_handler

private

  def exception_handler(exception)
    case exception.class.to_s
    when 'CanCan::AccessDenied'
      redirect_to root_url, alert: exception.message
    end
  end
end
