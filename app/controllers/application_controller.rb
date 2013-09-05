class ApplicationController < ActionController::Base
  protect_from_forgery

  def authenticate_user_through_bcms
    user = current_user

    redirect_to '/' if user.guest?

#    if user.guest?
#      redirect_to "/system/access-denied"
#    else
#      redirect_to "/my_target/page"
#    end
  end
end
