class HomeController < ApplicationController
  def index
    @example_path = petition_path(:id=> WeThePeopleHelper::EXAMPLE_PETITION_ID, :only_path => false)
    @example_json_path = petition_path(:id=> WeThePeopleHelper::EXAMPLE_PETITION_ID, :only_path => false, :format => 'json')
  end
end
