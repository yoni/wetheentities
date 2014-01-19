require 'test_helper'

class PetitionTest < ActionView::TestCase
  def setup
    @petition = WeThePeople::Resources::Petition.all.first
    @id = @petition.id
    @key = "#{Petition::PETITION_CACHE_PREFIX}:#{@id}"
    REDIS.del @key
  end
  def teardown
    REDIS.del @key
  end

  def run_enhancement
    result = Petition.find(@id)
    assert_not_nil result
    assert_equal false, result['analysis_complete']
    assert_equal true, result['analysis_queued']
    EnhancerWorker.drain
    result = Petition.find(@id)
    assert_equal true, result['analysis_complete']
    result
  end

  test 'should be able to load a petition and get its entities' do
    result = Petition.find(@id)
    assert_not_nil result
  end

  # Runs enhancement once, then deleted the analysis_complete flag, expecting that it will run the analysis a second
  # time
  test 'should be able to recover from a failed enhancement job by rerunning enhancement' do
    result = run_enhancement
    result.delete('analysis_queued')
    REDIS.set(@key, result.to_json)
    run_enhancement
  end
end
