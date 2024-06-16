require "test_helper"

class AttachmentTest < ActiveSupport::TestCase

  should "know what type of attachment this is" do
    assert attachments(:one).is_image?
    assert !attachments(:two).is_image?
    assert !attachments(:one).is_document?
    assert attachments(:two).is_document?
  end

  should "convert vanilla paths to archive paths" do
    assert_equal 'uploads/ab/something.png', attachments(:one).path
    assert_equal 'uploads/thumb/cd/blah.jpg', attachments(:one).thumb_path
    assert_equal 'uploads/ef/manifesto.pdf', attachments(:two).path
    assert_nil   attachments(:two).thumb_path
  end

end
