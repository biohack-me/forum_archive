source "https://rubygems.org"

gem 'rails', '~>8.0.0'
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

# FIXME: needed on ruby 3.3.3 ( https://github.com/ruby/net-pop/issues/26#issuecomment-2176572171 )
gem 'net-pop', github: 'ruby/net-pop'