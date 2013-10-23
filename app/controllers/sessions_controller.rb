class SessionsController < Devise::SessionsController
  def new
    render layout: 'admin'
  end
end
