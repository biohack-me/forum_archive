require "test_helper"

class CategoriesControllerTest < ActionController::TestCase

  should "get index" do
    get :index
    assert_response :success
  end

  should "get show" do
    get :show, params: { id: categories(:one).id }
    assert_response :success
  end

end
