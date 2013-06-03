require 'test_helper'

class HomeControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end
  test "should get api" do
    get :api
    assert_response :success
    %w(issues statuses signatures).each do |filter|
      assert_not_nil assigns("example_collection_#{filter}_filter_path".to_sym)
    end
  end
  test "should get gallery" do
    get :gallery
    assert_response :success
  end
end
