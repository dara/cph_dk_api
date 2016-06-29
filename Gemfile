source 'https://rubygems.org'

gem 'rails', '>= 5.0.0.rc1', '< 5.1'
gem 'puma', '~> 3.0'
gem 'nokogiri'

group :production do
  gem 'pg'
end

group :development, :test do
  gem 'byebug', platform: :mri
  gem 'rspec-rails', '3.5.0.beta4'
  gem 'rails-controller-testing' # continue using 'assigns' with RSpec
  gem 'rubocop', require: false
  gem 'webmock'
  gem 'sqlite3'
end

group :development do
  gem 'listen', '~> 3.0.5'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
