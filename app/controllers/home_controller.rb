class HomeController < ApplicationController
  caches_page :index
  def index
  end
  def api
    @petition_id = WeThePeopleHelper::EXAMPLE_PETITION_ID
    @example_path = petition_path(:id=> @petition_id, :only_path => false)
    @example_json_path = petition_path(:id=> @petition_id, :only_path => false, :format => 'json')
  end
end
