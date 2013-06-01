require 'test_helper'

class PetitionsControllerTest < ActionController::TestCase
  def test_get
    get(:show, { :id => WeThePeopleHelper::EXAMPLE_PETITION_ID })
    assert_response :success
    assert_not_nil assigns(:petition)
  end
  def test_get_json
    get(:show, {:id => WeThePeopleHelper::EXAMPLE_PETITION_ID, :format => 'json'})
    assert_response :success
    assert_not_nil assigns(:petition)
  end
  def test_index
    get(:index)
    assert_response :success
    assert_not_nil assigns(:collection)
    assert_not_nil assigns(:issues)
    assert_not_nil assigns(:statuses)
    assert_not_nil assigns(:signatures)
  end
  def test_index_json
    get(:index, {:format => 'json'})
    assert_response :success
    assert_not_nil assigns(:collection)
  end
  def test_index_with_all_criteria
    get(:index, {:issues => ['Health Care'], :statuses => ['responded'], :signatures => 1000})
    assert_response :success
    assert_not_nil assigns(:collection)
    assert_not_nil assigns(:issues)
    assert_not_nil assigns(:statuses)
    assert_not_nil assigns(:signatures)
  end
  def test_clear_collections_cache
    key = "#{Petition::COLLECTION_CACHE_PREFIX}:1234"
    REDIS.set(key, 'foo')
    CacheHelper.clear_collections_cache
    assert !REDIS.exists(key)
  end
end
