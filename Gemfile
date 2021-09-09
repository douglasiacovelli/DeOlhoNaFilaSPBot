# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.2'

gem 'bootsnap', '>= 1.4.4', require: false
gem 'faraday', '1.7.1'
gem 'faraday_middleware', '1.1.0'
gem 'jbuilder', '~> 2.7'
gem 'pg', '1.2.3'
gem 'puma', '~> 5.0'
gem 'rails', '~> 6.1.2', '>= 6.1.2.1'
gem 'sass-rails', '>= 6'
gem 'sidekiq', '6.2.2'
gem 'sidekiq-scheduler', '3.1.0'
gem 'turbolinks', '~> 5'
gem 'webpacker', '~> 5.0'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
end

group :development do
  gem 'listen', '~> 3.3'
  gem 'rack-mini-profiler', '~> 2.0'
  gem 'rubocop-rails', require: false
  gem 'spring'
  gem 'web-console', '>= 4.1.0'
end

group :test do
  gem 'capybara', '>= 3.26'
  gem 'selenium-webdriver'
  gem 'sqlite3', '~> 1.4'
  gem 'webdrivers'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
