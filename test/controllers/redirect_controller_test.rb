require "test_helper"

class RedirectControllerTest < ActionController::TestCase

  should "get redirected to root path with no query string" do
    get :redirect, params: { p: '' }
    assert_template 'application/404'
  end

  should "get redirected to category when appropriate" do
    get :redirect, params: { p: '/categories/announcements' }
    assert_response :moved_permanently
    assert_redirected_to category_path(1)
    get :redirect, params: { p: '/categories/something_fake' }
    assert_template 'application/404'
  end

  should "get redirected to discussion when appropriate" do
    get :redirect, params: { p: '/discussion/2567/forums-shutting-down-july-15' }
    assert_response :moved_permanently
    assert_redirected_to discussion_path(2567)
    get :redirect, params: { p: '/discussion/9999/something-fake' }
    assert_template 'application/404'
  end

  should "get redirected to user profile when appropriate" do
    get :redirect, params: { p: '/profile/Biohack_bot' }
    assert_response :moved_permanently
    assert_redirected_to user_path(5)
    get :redirect, params: { p: '/profile/Someone_fake' }
    assert_template 'application/404'
  end

  should "get redirected to root path with unexpected query string" do
    get :redirect, params: { p: '/something/else' }
    assert_template 'application/404'
  end

end
