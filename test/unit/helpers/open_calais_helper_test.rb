require 'test_helper'

class OpenCalaisHelperTest < ActionView::TestCase
  test 'should be able to hit the Open Calais web service' do
    petition_text = """VEPTR is a life saving concept for the treatment of Thoracic Insufficiency Syndrome. Thoracic Insufficiency Syndrome is the inability of the thorax to support normal respiration or lung growth. It occurs in young children with severe rib and chest wall malformations often associated with scoliosis.

VEPTR is designed to mechanically stabilize and distract the thorax to improve respiration and lung growth. VEPTR devices control and may correct scoliosis and helps patients have room to breathe.

Between 500-600 children and adults are affected by Thorasic Insuffensy and this is their only hope at a longer life. This day is needed to create support for the families as well as the children. Bringing awareness to this could save more lives as it could be more widespread than is known
"""
    result = OpenCalaisHelper.enhance petition_text
    assert_not_nil result
  end
end

