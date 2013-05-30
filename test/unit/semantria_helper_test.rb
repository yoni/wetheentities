require 'test_helper'

class SemantriaHelperTest < ActionView::TestCase
  initial_texts = [
      'Lisa - there\'s 2 Skinny cow coupons available $5 skinny cow ice cream coupons on special k boxes
   and Printable FPC from facebook - a teeny tiny cup of ice cream. I printed off 2
   (1 from my account and 1 from dh\'s). I couldn\'t find them instore and i\'m not going to walmart
   before the 19th. Oh well sounds like i\'m not missing much ...lol',

      "In Lake Louise - a guided walk for the family with Great Divide Nature Tours  rent a canoe
   on Lake Louise or Moraine Lake  go for a hike to the Lake Agnes Tea House. In between Lake Louise
   and Banff - visit Marble Canyon or Johnson Canyon or both for family friendly short walks. In Banff
   a picnic at Johnson Lake  rent a boat at Lake Minnewanka  hike up Tunnel Mountain  walk to the Bow Falls
   and the Fairmont Banff Springs Hotel  visit the Banff Park Museum. The \"must-do\" in Banff is a visit
   to the Banff Gondola and some time spent on Banff Avenue - think candy shops and ice cream.",

      'On this day in 1786 - In New York City  commercial ice cream was manufactured for the first time.'
  ]

  test 'should be able to analyze individual documents' do

    documents = initial_texts.map do |text|
      # Creates a sample document which need to be processed on Semantria
      # Unique document ID
      # Source text which need to be processed
      {'id' => rand(10 ** 10).to_s.rjust(10, '0'), 'text' => text}
    end

    results = SemantriaHelper.enhance_documents documents

    assert(!results.empty?)

    results.each do |data|
      # Printing of document sentiment score
      Rails.logger.info "Document #{data['id']}, Sentiment score: #{data['sentiment_score']}"
      assert_not_nil data['id']
      assert_not_nil data['sentiment_score']

      # Printing of document themes
      Rails.logger.info 'Document themes:'
      data['themes'].nil? or data['themes'].each do |theme|
        assert_not_nil theme['title']
        assert_not_nil theme['sentiment_score']
        Rails.logger.info "  #{theme['title']} (sentiment: #{theme['sentiment_score']})"
      end

      # Printing of document entities
      Rails.logger.info 'Entities:'
      data['entities'].nil? or data['entities'].each do |entity|
        assert_not_nil entity['title']
        assert_not_nil entity['entity_type']
        assert_not_nil entity['sentiment_score']
        Rails.logger.info "  #{entity['title']} : #{entity['entity_type']} (sentiment: #{entity['sentiment_score']})"
      end

    end
  end
  test 'should be able to analyze a collection' do

    result = SemantriaHelper.enhance_collection({:id => '123', :documents => initial_texts})

    Rails.logger.info result

    Rails.logger.info "Collection #{result['id']}"
    assert_not_nil result['id']

    # Printing of collection themes
    Rails.logger.info 'Document themes:'
    result['themes'].nil? or result['themes'].each do |theme|
      assert_not_nil theme['title']
      assert_not_nil theme['sentiment_score']
      Rails.logger.info "  #{theme['title']} (sentiment: #{theme['sentiment_score']})"
    end

    # Printing of collection entities
    Rails.logger.info 'Entities:'
    result['entities'].nil? or result['entities'].each do |entity|
      %w(title count entity_type negative_count positive_count neutral_count).each {|field|
        assert_not_nil entity[field]
      }
      Rails.logger.info "  #{entity['title']} : #{entity['entity_type']} (count: #{entity['count']})"
    end
  end
end
