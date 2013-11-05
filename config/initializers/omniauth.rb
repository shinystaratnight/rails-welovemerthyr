Rails.application.config.middleware.use OmniAuth::Builder do
  #provider :facebook, ENV['FACEBOOK_KEY'], ENV['FACEBOOK_SECRET']

  if Rails.env.development?
    provider :facebook, '1410335719200136', '60903fd84777ac414d7003540667ce48', { scope: 'user_about_me,user_status,email,publish_stream,offline_access', display: 'popup'  }
  elsif Rails.env.production?
#    provider :facebook, '', ''
  end
end
