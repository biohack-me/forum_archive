require "test_helper"

class CommentTest < ActiveSupport::TestCase

  should belong_to :discussion
  should have_one  :creator
  should have_many :attachments

end
