require "test_helper"

class BadgesControllerTest < ActionController::TestCase

  should "get show" do
    get :show, params: { id: badges(:one).id }
    assert_response :success
  end

end
