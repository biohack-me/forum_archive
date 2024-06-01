require "test_helper"

class CategoryTest < ActiveSupport::TestCase

  should have_many :discussions
  should have_many :comments

end
