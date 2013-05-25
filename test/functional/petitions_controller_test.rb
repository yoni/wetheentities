require 'test_helper'

class PetitionsControllerTest < ActionController::TestCase
  def test_get
    get(:show, { :id => WeThePeopleHelper::EXAMPLE_PETITION_ID })
    assert_response :success
    assert_not_nil assigns(:petition)
  end
  def test_get_json
    get(:show, { :id => WeThePeopleHelper::EXAMPLE_PETITION_ID, :format => 'json'})
    assert_response :success
    assert_not_nil assigns(:petition)
  end
end
