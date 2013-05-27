class HomeController < ApplicationController
  def index
    @petition_id = WeThePeopleHelper::EXAMPLE_PETITION_ID
    @example_path = petition_path(:id=> @petition_id, :only_path => false)
    @example_json_path = petition_path(:id=> @petition_id, :only_path => false, :format => 'json')
  end
end
