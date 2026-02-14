source "https://rubygems.org"

gem 'rails', '~>8.1.0'
gem 'mysql2'
gem 'puma'

gem 'haml'
gem 'haml-rails'
gem "dartsass-rails"
gem 'sprockets-rails'
gem 'redcarpet'
gem 'rails_autolink'
gem 'jquery-rails'
gem 'terser'
gem 'actionpack-action_caching'
gem 'will_paginate'
gem 'rack-attack'

group :test do

  gem 'minitest', '<6.0',        require: false # apparently you currently have to either use minitest <6 or a specific branch of rails for tests to actually run - see https://github.com/rails/rails/issues/56406 and https://github.com/minitest/minitest/issues/1040

  # a bug in shoulda-context causes tests to stop after the first failure with a "undefined local variable or method `executable' for an instance of Rails::TestUnitReporter (NameError)" - see https://github.com/thoughtbot/shoulda-context/issues/109
  #gem 'shoulda',                 require: false
  gem "shoulda-context", "~> 3.0.0.rc1",  require: false
  gem "shoulda-matchers",                 require: false

  gem 'rails-controller-testing'
end

group :production do
  gem 'exception_notification'
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