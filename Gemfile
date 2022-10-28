source 'https://rubygems.org'

# Specify Ruby version. Heroku has recent version.
#ruby "~> 2.6.1"
ruby '~>3.1.2'
gem "json", ">= 2.3.0"

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
#gem 'rails', '5.2.4.6'
gem 'rails', '~>7.0'

# Use Postgres for database
#gem 'pg', '1.2.3'
gem 'mysql2', '>= 0.5', '< 0.5.4'

# Use Puma as the app server
gem 'puma', '~> 5.6', '>= 5.6.5'

gem 'actionpack', '~>7.0'

gem "nokogiri", "~> 1.13"
# General library for manipulating & transforming HTML/XML documents &
# fragments, built on top of Nokogiri.
gem "loofah", ">= 2.3.1"

# Use SCSS for stylesheets
gem 'sass-rails', '>= 6.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 4.2.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '>= 5.0.0'

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks', '~> 5.2.1'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '>= 2.11.5'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '>= 2.0.3', group: :doc

# Use ActiveModel has_secure_password
gem 'bcrypt', '>= 3.1.13'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '>= 4.2.0'
  gem 'listen', '~> 3.7.1'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring', '>= 3.0'

  # Use Capistrano for deployment
  # gem 'capistrano-rails'
end

group :production do
  # Enables features like static asset serving, i.e., images & logging onto Heroku
  # Use pg gem for Deployment on Heroku
  gem 'pg', '1.2.3'
  gem 'rails_12factor'
end

gem 'rb-readline'
