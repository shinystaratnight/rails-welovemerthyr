source 'https://rubygems.org'

ruby '1.9.3'
gem 'rails', '3.2.14'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platforms => :ruby

  gem 'uglifier', '>= 1.0.3'
end

# misc
gem 'thin'
gem 'jquery-rails'
gem 'simple_form'
gem 'faker'
gem 'mailcatcher', group: :development
gem 'kaminari'

# twitter bootstrap related
gem 'therubyracer'
gem 'less-rails'
gem 'twitter-bootstrap-rails'

# mongoid related
gem 'mongoid', '~> 3.0.0'
gem 'mongoid_taggable'
gem 'mongoid_slug'

# Upload, images processing.
gem 'carrierwave-mongoid', require: 'carrierwave/mongoid'
gem 'mini_magick'
gem 'fog'

# Geographic
gem 'geocoder' # move this gem to under mecury-rails gem won't work, strange.
gem 'gmaps4rails'

# Authentication, authorization.
gem 'devise'
gem 'cancan'

# Test tool
group :development, :test do
  gem 'rspec-rails'
  gem 'factory_girl_rails'
  gem 'capybara'
end

gem 'rails_12factor' # to skip plugin injection

gem 'tire' # for eslasticsearch on Heroku
