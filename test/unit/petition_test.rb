require 'test_helper'

class PetitionTest < ActionView::TestCase
  def setup
    @petition = WeThePeople::Resources::Petition.all.first
    @id = @petition.id
    @key = "petition:#{@id}"
    REDIS.del @key
  end
  def teardown
    REDIS.del @key
  end
  test 'should be able to load a petition and get its entities' do
    result = Petition.find(@id)
    assert_not_nil result
  end
  test 'should be able to recover from a failed enhancement job by rerunning enhancement' do
    result = Petition.find(@id)
    assert_not_nil result
    assert_nil result['analysis_complete']
    EnhancerWorker.drain
    result = Petition.find(@id)
    assert_not_nil result['analysis_complete']

    result.delete('analysis_complete')
    REDIS.set(@key, result.to_json)
    result = Petition.find(@id)
    assert_not_nil result
    assert_nil result['analysis_complete']
    EnhancerWorker.drain
    result = Petition.find(@id)
    assert_not_nil result['analysis_complete']
  end
end
