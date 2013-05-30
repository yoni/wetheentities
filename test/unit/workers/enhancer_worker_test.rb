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
    REDIS.set(@petition['attributes']['id'], @petition.to_json)
  end

  def teardown
    REDIS.del(@petition['attributes']['id'])
  end

  # see https://github.com/mperham/sidekiq/wiki/Testing
  test 'should be able to queue a job for enhancing a petition' do
    assert_equal 0, EnhancerWorker.jobs.size
    EnhancerWorker.perform_async(@petition['attributes']['id'])
    assert_equal 1, EnhancerWorker.jobs.size
    assert_equal @petition['attributes']['id'], EnhancerWorker.jobs[0]['args'][0]
    EnhancerWorker.drain
    assert_equal 0, EnhancerWorker.jobs.size
  end
end
