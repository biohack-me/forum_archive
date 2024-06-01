require "test_helper"

class DiscussionsControllerTest < ActionController::TestCase

  should "get show" do
    get :show, params: { id: discussions(:one).id }
    assert_response :success
  end

end
