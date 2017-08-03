source "https://rubygems.org"
ruby "2.3.1"

# Use https:// rather than git:// as the protocol for gems installed
# from GitHub. This will be the default in Bundler 2.0 and resolves
# a bug with deploying from Heroku.
# https://github.com/bundler/bundler/issues/4978#issuecomment-272248627
git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

# Bundle edge Rails instead: gem "rails", github: "rails/rails"
gem "rails", "~> 5.1.2"

gem "pg"
gem "pg_search"

gem "cancan"
gem "omniauth-google-oauth2"
gem "devise"
gem "hangry", github: "boblail/hangry", branch: "master"
gem "redcarpet"

gem "carrierwave"
gem "fog"
gem "mini_magick"

gem "puma", "~> 3.7"

# Use SCSS for stylesheets
gem "sass-rails", "~> 5.0"

# Use Uglifier as compressor for JavaScript assets
gem "uglifier", ">= 1.3.0"

# Use CoffeeScript for .js.coffee assets and views
gem "coffee-rails", "~> 4.2"

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem "therubyracer",  platforms: :ruby

# Use jquery as the JavaScript library
gem "jquery-rails"

# For deploying to Heroku
gem "rails_12factor", group: :production

group :development, :test do
  # Use PRY for debugging
  gem "pry", group: [:development, :test]
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  # gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  # Adds support for Capybara system testing and selenium driver
  gem "capybara", "~> 2.13"
  gem "selenium-webdriver"
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem "web-console", ">= 3.3.0"
  gem "listen", ">= 3.0.5", "< 3.2"
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]
