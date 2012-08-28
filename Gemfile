source 'http://rubygems.org'

gem 'rake'
gem 'rails', '3.2.8'
gem 'rack'

gem "will_paginate", '>= 3.0'

#forms
#gem "formtastic"
#gem "formtastic-bootstrap"
gem "simple_form", '>= 2.0.1'


gem "jquery-rails"
gem "cancan"
gem "gravatar_image_tag"

#authentication library
# - using custom authentication with optional POP3 authentication
#gem "sorcery"
gem "bcrypt-ruby"

#web server
#gem "thin"
gem "passenger"
#gem "heroku"

#rails 3.1
group :assets do
    gem "less-rails-bootstrap"
    gem "sass-rails"
    gem "coffee-script"
    gem "uglifier"
end

#markup
gem "haml"

#Delayed Job
gem "delayed_job_active_record"
gem "daemons"
gem "delayed_job_web"

#Spreadsheet interface (for GovwinIQ)
gem "roo"
gem 'nokogiri'
gem 'mechanize'

#error/issue reporting to GitHub
gem "octokit"

gem "lazy_high_charts"
gem "RedCloth"
gem "switch_user"
gem "hoptoad_notifier"
gem 'acts-as-taggable-on'

gem 'faker' #needed for rake tasks

group :development do
    gem 'annotate'
#   gem 'rails-footnotes', '~> 3.7.1.rc1'
end

group :test do
    gem 'spork'
    gem 'factory_girl_rails'
    gem 'simplecov', require: false
end

group :development, :test do
    gem 'sqlite3'
    gem 'rspec'
    gem 'rspec-rails'
    gem 'capybara'
    gem 'ruby-debug19'
end

group :production do
    gem 'therubyracer'
    gem "pg"            # use postgresql in production
end

# Deploy with Capistrano
gem 'capistrano'

# To use debugger (ruby-debug for Ruby 1.8.7+, ruby-debug19 for Ruby 1.9.2+)
# gem 'ruby-debug'
# gem 'ruby-debug19'

