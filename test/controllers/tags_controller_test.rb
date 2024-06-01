require "test_helper"

class TagsControllerTest < ActionController::TestCase

  should "get show" do
    get :show, params: { tag: 'test' }
    assert_response :success
  end

end
