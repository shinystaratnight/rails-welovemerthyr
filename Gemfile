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

gem 'thin'
gem 'jquery-rails'
gem 'simple_form'
gem "ckeditor"

gem "therubyracer"
gem "less-rails"
gem 'twitter-bootstrap-rails'

gem 'mongoid', '~> 3.0.0'
gem 'mongoid_taggable'

gem 'carrierwave-mongoid', require: 'carrierwave/mongoid'
gem 'mini_magick'
gem 'fog'
gem 'geocoder' # move this gem to under mecury-rails gem won't work, strange.

gem 'devise'
gem 'cancan'

group :development, :test do
  gem 'rspec-rails'
  gem 'factory_girl_rails'
  gem 'faker'
end
