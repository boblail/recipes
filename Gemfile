source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "2.6.3"


# Bundle edge Rails instead: gem "rails", github: "rails/rails"
gem "rails", "~> 5.2.1"

gem "pg"
gem "pg_search"

gem "cancan"
gem "omniauth-google-oauth2"
gem "devise"
gem "hangry", github: "boblail/hangry", branch: "20191027"
gem "ingreedy", github: "cookpad/ingreedy", branch: "master"
gem "redcarpet"

gem "turbolinks", "~> 5.0.0"

gem "carrierwave-aws"
gem "mini_magick"

gem "puma", "~> 3.12"
gem "bootsnap", "~> 1.1"

# Use SCSS for stylesheets
gem "sass-rails", "~> 5.0"

# Use ActiveStorage variant
# gem 'mini_magick', '~> 4.8'

# Use Uglifier as compressor for JavaScript assets
gem "uglifier", ">= 1.3.0"

# Use CoffeeScript for .js.coffee assets and views
gem "coffee-rails", "~> 4.2"
gem "react-rails", "~> 1.10.0"

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'mini_racer', platforms: :ruby

# Use jquery as the JavaScript library
gem "jquery-rails"

# For deploying to Heroku
gem "rails_12factor", group: :production

# For reporting exceptions
gem "sentry-raven"

group :development, :test do
  gem "pry"
  gem "awesome_print"

  # Adds support for Capybara system testing and selenium driver
  gem "capybara", "~> 2.13"
  gem "selenium-webdriver"

  gem "factory_bot_rails"
  gem "shoulda-context"
  gem "minitest-reporters"
  gem "minitest-reporters-turn_reporter"
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
