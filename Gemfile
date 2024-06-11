source "https://rubygems.org"

ruby "3.2.2"

gem 'rails', '~> 7.1.3'
gem 'mysql2'
gem 'puma'

gem 'haml'
gem 'sassc-rails'
gem 'sprockets-rails'
gem 'redcarpet'
gem 'rails_autolink'
gem 'jquery-rails'
gem 'actionpack-action_caching'
gem 'will_paginate'

group :test do
  gem 'minitest',                require: false
  gem 'shoulda',                 require: false
  gem 'rails-controller-testing'
end

group :production do
  gem 'exception_notification'
  gem 'mini_racer'
end

group :development do
  gem "awesome_print",      require: false
  gem "pry-rails",          require: false
  gem 'capistrano',         require: false
  gem 'capistrano-rvm',     require: false
  gem 'capistrano-bundler', require: false
  gem 'capistrano-rails',   require: false
  gem 'capistrano3-puma',   require: false, github: 'seuros/capistrano-puma'
  gem 'brakeman',           require: false
  gem 'faker',              require: false
end