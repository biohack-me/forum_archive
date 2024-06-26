require "test_helper"

class DiscussionTest < ActiveSupport::TestCase

  should belong_to :category
  should have_many :comments
  should have_one  :creator
  should have_one  :last_user
  should have_many :attachments

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

  should "know how many pages of comments it will have, and what page those comments are on" do
    for i in 0..70 do
      discussions(:one).comments.build(id: i.to_i+10, created: discussions(:one).created+(i.to_i).minutes)
    end
    assert_equal 72, discussions(:one).comments.size, discussions(:one).comments.inspect
    assert_equal 3, discussions(:one).num_comment_pages
    assert_equal 2, discussions(:one).comment_page(discussions(:one).comments[45].id)
  end

end
