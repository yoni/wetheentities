require 'test_helper'

class CollectionEnhancerWorkerTest < ActionView::TestCase

  def setup
    petitions = [
        {
            'attributes' => {
                'id' => '12345',
                'title' => 'hello im a petition about blahdy blah.',
                'body' => 'Lisa - there\'s 2 Skinny cow coupons available $5 skinny cow ice cream coupons on special k boxes
   and Printable FPC from facebook - a teeny tiny cup of ice cream. I printed off 2
   (1 from my account and 1 from dh\'s). I couldn\'t find them instore and i\'m not going to walmart
   before the 19th. Oh well sounds like i\'m not missing much ...lol'
            }
        },
        {
            'attributes' => {
                'id' => '67890',
                'title' => 'and a second petition about blahdy foo.',
                'body' => 'VEPTR is a life saving concept for the treatment of Thoracic Insufficiency Syndrome.
Thoracic Insufficiency Syndrome is the inability of the thorax to support normal respiration or lung growth.
It occurs in young children with severe rib and chest wall malformations often associated with scoliosis.
VEPTR is designed to mechanically stabilize and distract the thorax to improve respiration and lung growth.
VEPTR devices control and may correct scoliosis and helps patients have room to breathe.
Between 500-600 children and adults are affected by Thorasic Insuffensy and this is their only hope at a longer life.
This day is needed to create support for the families as well as the children. Bringing awareness to this could save
more lives as it could be more widespread than is known'
            }
        }
    ]

    @key = 'my_big_fat_collection'
    @collection = {
        :key => @key,
        :petitions => petitions
    }
    REDIS.set(@key, @collection.to_json)
  end

  def teardown
    REDIS.del(@key)
  end

  # see https://github.com/mperham/sidekiq/wiki/Testing
  test 'should be able to queue a job for enhancing a collection' do
    CollectionEnhancerWorker.jobs.clear
    assert_equal 0, CollectionEnhancerWorker.jobs.size
    CollectionEnhancerWorker.perform_async(@key)
    assert_equal 1, CollectionEnhancerWorker.jobs.size
    assert_equal @key, CollectionEnhancerWorker.jobs[0]['args'][0]
    CollectionEnhancerWorker.drain
    assert_equal 0, CollectionEnhancerWorker.jobs.size
    collection = REDIS.get(@key)
    assert collection['analysis_complete']
  end
end
