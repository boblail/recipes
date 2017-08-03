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
gem "rails", "~> 4.2.0"

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

gem "puma"

# Use SCSS for stylesheets
gem "sass-rails", "~> 4.0.3"

# Use Uglifier as compressor for JavaScript assets
gem "uglifier", ">= 1.3.0"

# Use CoffeeScript for .js.coffee assets and views
gem "coffee-rails", "~> 4.0.0"

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem "therubyracer",  platforms: :ruby

# Use jquery as the JavaScript library
gem "jquery-rails"

# Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
gem "spring", group: :development

# For deploying to Heroku
gem "rails_12factor", group: :production

# Use PRY for debugging
gem "pry", group: [:development, :test]
