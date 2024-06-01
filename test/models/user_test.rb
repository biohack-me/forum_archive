require "test_helper"

class UserTest < ActiveSupport::TestCase

  should have_many   :discussions
  should have_many   :comments
  should have_many   :user_badges
  should have_many   :badges
  should have_many   :user_roles
  should have_many   :roles
  should have_many   :user_meta

  should "get correct photo_url" do
    assert_equal 'userpics/F2IH2KPW2RWL/nGBH6RG50OK5K.png', users(:one).photo_url
    assert_equal 'userpics/F2IH2KPW2RWL/nGBH6RG50OK5K.png', users(:one).photo_url('small')
    assert_equal 'userpics/F2IH2KPW2RWL/pGBH6RG50OK5K.png', users(:one).photo_url('big')

    assert_equal 'userpics/101/nX9WCZXGGN4XZ.jpg', users(:two).photo_url
    assert_equal 'userpics/101/nX9WCZXGGN4XZ.jpg', users(:two).photo_url('small')
    assert_equal 'userpics/101/pX9WCZXGGN4XZ.jpg', users(:two).photo_url('big')

    assert_equal 'https://example.com/picture.gif', users(:three).photo_url
    assert_equal 'https://example.com/picture.gif', users(:three).photo_url('small')
    assert_equal 'https://example.com/picture.gif', users(:three).photo_url('big')

    user_four_emailhash = Digest::MD5.hexdigest(users(:four).email.downcase)
    user_four_small_photo_url = "https://gravatar.com/avatar/#{user_four_emailhash}?s=40&d=https%3A%2F%2Fapi.dicebear.com%2F8.x%2Fbottts%2Fpng%2Fseed%3D#{user_four_emailhash}"
    user_four_big_photo_url = "https://gravatar.com/avatar/#{user_four_emailhash}?s=200&d=https%3A%2F%2Fapi.dicebear.com%2F8.x%2Fbottts%2Fpng%2Fseed%3D#{user_four_emailhash}"
    assert_equal user_four_small_photo_url, users(:four).photo_url
    assert_equal user_four_small_photo_url, users(:four).photo_url('small')
    assert_equal user_four_big_photo_url, users(:four).photo_url('big')

    user_five_emailhash = Digest::MD5.hexdigest(users(:five).email.downcase)
    user_five_small_photo_url = "https://gravatar.com/avatar/#{user_five_emailhash}?s=40&d=https%3A%2F%2Fapi.dicebear.com%2F8.x%2Fbottts%2Fpng%2Fseed%3D#{user_five_emailhash}"
    user_five_big_photo_url = "https://gravatar.com/avatar/#{user_five_emailhash}?s=200&d=https%3A%2F%2Fapi.dicebear.com%2F8.x%2Fbottts%2Fpng%2Fseed%3D#{user_five_emailhash}"
    assert_equal user_five_small_photo_url, users(:five).photo_url
    assert_equal user_five_small_photo_url, users(:five).photo_url('small')
    assert_equal user_five_big_photo_url, users(:five).photo_url('big')
  end

  should "know if email should be shown on profile" do
    assert users(:one).show_email?
    assert !users(:two).show_email?
    assert !users(:three).show_email?
  end

  should "know if this is a private profile" do
    assert !users(:one).private?
    assert !users(:two).private?
    assert users(:three).private?
  end

  should "know user pronouns" do
    assert_equal 'it it its', users(:one).pronouns
    assert_equal 'they them theirs', users(:two).pronouns
  end

  should "know user skills" do
    assert_equal 'programming', users(:one).skills
    assert_equal '',            users(:two).skills
  end

end
