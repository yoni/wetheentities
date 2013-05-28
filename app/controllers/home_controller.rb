class HomeController < ApplicationController
  caches_page :index
  def index
    @petition_id = WeThePeopleHelper::EXAMPLE_PETITION_ID
    @example_path = petition_path(:id=> @petition_id, :only_path => false)
    @example_json_path = petition_path(:id=> @petition_id, :only_path => false, :format => 'json')
    @petitions = WeThePeople::Resources::Petition.all.first(4)
    @location_petition_example = WeThePeople::Resources::Petition.find(WeThePeopleHelper::TAIWAN_PETITION_ID)
  end
end
