ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"
require 'shoulda-matchers'
require 'minitest/pride'
Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :minitest
    with.library :rails
  end
end
require 'shoulda-context'

module ActiveSupport
  class TestCase
    #parallelize(workers: :number_of_processors) # some tests were causing all tests to fail with `DRb::DRbRemoteError` with parallelization enabled
    fixtures :all
  end
end
