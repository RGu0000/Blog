source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = '#{repo_name}/#{repo_name}' unless repo_name.include?('/')
  'https://github.com/#{repo_name}.git'
end

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.1.5'
# Use postgresql as the database for Active Record
gem 'pg', '>= 0.18', '< 2.0'
# Use Puma as the app server
gem 'puma', '~> 3.7'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
gem 'bootstrap-sass', '~> 3.3.7'
gem 'jquery-rails'
gem 'closure_tree'
# Adding sidekiq + redis
gem 'sidekiq'
gem 'redis-rails'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
gem 'therubyracer'
gem 'less-rails-bootstrap'
gem 'jquery-easing-rails'
gem 'font-awesome-sass', '~> 5.0.6'
gem 'draper'
gem 'ffaker'
gem 'devise'
# HTTP Client
gem 'faraday'
gem 'html2haml'
gem 'haml-rails', '~> 1.0'
gem 'haml'
gem 'erb2haml'
gem 'will_paginate', '~> 3.1.0'
gem 'simple_form'

# Carriervawe for attaching the files to the app
gem 'carrierwave', '~> 1.0'
gem 'mini_magick'

# Grape for creating Api
gem 'grape'
gem 'grape-swagger'
gem 'grape-swagger-rails'
gem 'grape-active_model_serializers'

# Omniauth for Google authentication
gem 'omniauth-google-oauth2'
gem 'omniauth-facebook', '~> 3.0.0'

# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Authorization - pundit gem
gem 'pundit'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

gem 'rubocop', '~> 0.54.0', require: false

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '~> 2.13'
  gem 'selenium-webdriver'
  gem 'factory_bot_rails'
  gem 'rspec-rails', '~> 3.7'
  gem 'simplecov', require: false
  gem 'rails-controller-testing'
  gem 'shoulda-matchers', '~> 3.1'
end

# group :test do
#
# end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'bullet'
  gem 'pry-rails'


end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
