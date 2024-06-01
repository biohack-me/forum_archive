require "test_helper"

class BadgeTest < ActiveSupport::TestCase

  should have_many :user_badges
  should have_many :users

  should "convert photo path to a usable path in rails" do
    assert_equal 'badges/default_badges.svg#anniversary-1', badges(:one).image_path
    assert_equal 'badges/default_badges.svg#anniversary-2', badges(:two).image_path
  end

end
