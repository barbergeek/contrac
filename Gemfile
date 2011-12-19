source 'http://rubygems.org'

gem 'rake'
gem 'rails', '3.1.1'
gem 'rack', '1.3.5'

gem "will_paginate", '~> 3.0'
gem "formtastic"
gem "formtastic-bootstrap"
#gem "tabulous"
gem "jquery-rails"
gem "cancan"
gem "gravatar_image_tag"

#authentication library
gem "sorcery"

#web server
gem "thin"
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

gem "delayed_job"
gem "lazy_high_charts"
gem "RedCloth"
gem "switch_user"
gem "hoptoad_notifier"
gem 'nokogiri'
gem 'mechanize'
gem 'acts-as-taggable-on'

gem 'faker'	#needed for rake tasks
	
group :development do
	gem	'annotate'
#  	gem 'rails-footnotes', '~> 3.7.1.rc1'
end

group :test do
	gem 'spork'
	gem 'factory_girl_rails'
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
	gem "pg"			# use postgresql in production
end

# Deploy with Capistrano
gem 'capistrano'

# To use debugger (ruby-debug for Ruby 1.8.7+, ruby-debug19 for Ruby 1.9.2+)
# gem 'ruby-debug'
# gem 'ruby-debug19'

