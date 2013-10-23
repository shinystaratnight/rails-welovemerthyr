class PasswordsController < Devise::PasswordsController
  layout 'admin', only: [:new, :create]
end
