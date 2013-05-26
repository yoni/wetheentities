require 'test_helper'

class ExamplesControllerTest < ActionController::TestCase
  test "should get sentiment" do
    get :sentiment
    assert_response :success
  end

  test "should get geo" do
    get :geo
    assert_response :success
  end

end
