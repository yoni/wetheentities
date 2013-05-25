require 'test_helper'

class PetitionsControllerTest < ActionController::TestCase
  def test_get
    get(:show, { :id => '519e7eeaadfd950f72000003' })
    assert_response :success
    assert_not_nil assigns(:petition)
  end
end
