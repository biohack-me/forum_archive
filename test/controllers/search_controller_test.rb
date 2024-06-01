require "test_helper"

class SearchControllerTest < ActionController::TestCase

  should "get index" do
    get :index
    assert_response :success
  end

end
