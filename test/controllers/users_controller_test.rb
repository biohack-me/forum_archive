require "test_helper"

class UsersControllerTest < ActionController::TestCase

  should "get show" do
    get :show, params: { id: users(:one).id }
    assert_response :success
  end

end
