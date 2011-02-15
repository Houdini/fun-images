require 'test_helper'

class GridfsControllerControllerTest < ActionController::TestCase
  test "should get serve" do
    get :serve
    assert_response :success
  end

end
