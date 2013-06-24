# encoding: utf-8
require 'test_helper'

class EnhancerWorkerTest < ActionView::TestCase

  def setup
    @petition = {
        'attributes' => {
            'id' => '12345',
            'title' => 'hello im a petition about blahdy blah.',
            'body' => 'Lisa - there\'s 2 Skinny cow coupons available $5 skinny cow ice cream coupons on special k boxes
   and Printable FPC from facebook - a teeny tiny cup of ice cream. I printed off 2
   (1 from my account and 1 from dh\'s). I couldn\'t find them instore and i\'m not going to walmart
   before the 19th. Oh well sounds like i\'m not missing much ...lol'
        }
    }
    @non_english_petition = {
        'attributes' => {
            'id' => '54321',
            'title' => %q{我们请求美国政府取缔北京煎饼果子},
            'body' => %q{长久以来，天津人们本着求同存异的原则，容忍某些北京个体户使用白面作为原材料制造所谓“煎饼果子\\\"。
正所谓“木秀于林，风必摧之”，树欲静而风不止。一些商贩把我们的善良当成了懦弱，不单使用白面替代绿豆面，甚至丧心病狂地将榨菜、
火腿肠甚至是生菜放置于煎饼夹层中，妄图喧宾夺主，视果篦于不顾。\\r\\n\\r\\n虽然通过和平手段解决争端是我们的一贯立场，但是忘战必危，
在事关核心利益的问题上，我们没有打不还手的雅兴。忍无可忍，无须再忍。\\r\\n\\r\\n在此，我们希望美国政府在天津煎饼果子才是正统这一问题上，
坚定立场，进行一场消灭北京煎饼果子的攻坚战。\\r\\n\\r\\n-北门串党党座}
        }
    }
    @id = @petition['attributes']['id']
    @non_english_petition_id = @non_english_petition['attributes']['id']
    REDIS.set(@id, @petition.to_json)
    REDIS.set(@non_english_petition_id, @non_english_petition.to_json)
  end

  def teardown
    REDIS.del(@id)
    REDIS.del(@non_english_petition_id)
  end

  # see https://github.com/mperham/sidekiq/wiki/Testing
  test 'should be able to queue a job for enhancing a petition' do
    EnhancerWorker.jobs.clear
    assert_equal 0, EnhancerWorker.jobs.size
    EnhancerWorker.perform_async(@petition['attributes']['id'])
    assert_equal 1, EnhancerWorker.jobs.size
    assert_equal @petition['attributes']['id'], EnhancerWorker.jobs[0]['args'][0]
    EnhancerWorker.drain
    assert_equal 0, EnhancerWorker.jobs.size
    petition = REDIS.get(@id)
    assert petition['analysis_complete']
  end

  test 'should be able to avoid analyzing non-English texts' do
    assert_equal 0, EnhancerWorker.jobs.size
    EnhancerWorker.perform_async(@non_english_petition['attributes']['id'])
    assert_equal 1, EnhancerWorker.jobs.size
    EnhancerWorker.drain
    assert_equal 0, EnhancerWorker.jobs.size
    petition = REDIS.get(@non_english_petition_id)
    assert petition['analysis_complete']
    assert petition['semantria'].nil?
    assert petition['open_calais'].nil?
  end
end
