# frozen_string_literal: true
ruby '2.4.0'
source "https://rubygems.org"

gem 'sinatra'
gem 'activerecord', :require => 'active_record'
gem 'sinatra-activerecord', :require => 'sinatra/activerecord'
gem 'require_all'
gem 'tux'
gem 'thin'
gem 'shotgun'
gem 'rake'
gem 'bcrypt'
gem 'pg'
gem 'pry'

gem 'sqlite3', :group => :development

group :test do
  gem 'rspec'
  gem 'capybara'
  gem 'rack-test'
  gem 'database_cleaner', git: 'https://github.com/bmabey/database_cleaner.git'
end
