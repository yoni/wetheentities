require 'test_helper'

class PetitionTest < ActionView::TestCase
  test 'should be able to load a petition and get its entities' do
    petitions = WeThePeople::Resources::Petition.all
    petition = petitions.first
    result = Petition.find(petition.id)
    assert_not_nil result
    assert_not_nil result[:open_calais]
    assert_not_nil result[:semantria]
  end
end
