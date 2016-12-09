class SessionsController < Devise::SessionsController
  def new
    render layout: 'new_admin'
  end
end
