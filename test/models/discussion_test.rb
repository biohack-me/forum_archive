require "test_helper"

class DiscussionTest < ActiveSupport::TestCase

  should belong_to :category
  should have_many :comments
  should have_one  :creator
  should have_one  :last_user

  should "know if it is an announcement" do
    assert !discussions(:one).announcement?
    assert discussions(:two).announcement?
    assert discussions(:three).announcement?
  end

  should "know if it is closed" do
    assert !discussions(:one).closed?
    assert !discussions(:two).closed?
    assert discussions(:three).closed?
  end

  should "convert tags to array" do
    assert_equal ['thing1','thing2 with a space'], discussions(:one).tag_list
    assert_equal ['thing3','thing4'], discussions(:two).tag_list
    assert_equal [],                  discussions(:three).tag_list
  end

end
