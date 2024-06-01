require "test_helper"

class UserRoleTest < ActiveSupport::TestCase

  should belong_to :user
  should belong_to :role

end
