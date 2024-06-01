require "test_helper"

class RoleTest < ActiveSupport::TestCase

  should have_many :user_roles
  should have_many :users

end
