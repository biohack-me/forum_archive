require "test_helper"

class UserBadgeTest < ActiveSupport::TestCase

  should belong_to :user
  should belong_to :badge

end
