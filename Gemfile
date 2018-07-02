source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.1.4'
# Use sqlite3 as the database for Active Record
gem 'sqlite3'
# Use Puma as the app server
gem 'puma', '~> 3.7'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
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
# Use Redis adapter to run Action Cable in production
gem 'redis', '~> 3.0'
gem 'bcrypt', '~> 3.1.7'

gem 'pry', '~> 0.11.3'
gem 'dotenv-rails', '~> 2.2.1'
gem 'facebook-messenger', '~> 1.0.0'
# Use Capistrano for deployment
gem 'capistrano-rails', group: :development

gem 'whenever', '~> 0.10.0'
gem 'stripe', '~> 3.11.0'
gem 'kaminari', '~> 1.1.1'
gem 'mandrill-api', '~> 1.0.53'
gem 'inky-rb', '~> 1.3.7.2', require: 'inky'
# Stylesheet inlining for email **
gem 'premailer-rails', '~> 1.10.1'
gem 'sidekiq', '~> 5.1.1'
gem 'webpacker', git: 'https://github.com/rails/webpacker.git'
gem 'httparty', '~> 0.15.7'
gem 'dogstatsd-ruby', '~> 3.3.0'
gem 'dogapi', '~> 1.28.0'
gem 'sendgrid', '~> 1.2.4'
group :development, :test do
  gem 'factory_bot_rails', '~> 4.8.2'
  gem 'rspec-rails', '~> 3.7'
end

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '~> 2.13'
  gem 'selenium-webdriver'
  gem 'mock_redis'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
