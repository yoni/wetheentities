class HomeController < ApplicationController
  caches_page :index
  def index
  end

  def api
    @petition_id = WeThePeopleHelper::EXAMPLE_PETITION_ID
    @example_petition_path = petition_path(:id=> @petition_id, :only_path => false)
    @example_petition_json_path = petition_path(:id=> @petition_id, :only_path => false, :format => 'json')
    @example_petition_jsonp_path = petition_path(:id=> @petition_id, :only_path => false, :format => 'js', :callback => 'jsonpCallback')

    @example_collection_path = petitions_path(:only_path => false)
    @example_collection_json_path = petitions_path(:only_path => false, :format => 'json')
    @example_collection_jsonp_path = petitions_path(:only_path => false, :format => 'js', :callback => 'jsonpCallback')
    @example_collection_issues_filter_path = clean_path(petitions_path(:issues => ['Health Care', 'Family'], :only_path => false))
    @example_collection_statuses_filter_path = clean_path(petitions_path(:statuses => ['responded', 'pending response'], :only_path => false))
    @example_collection_signatures_filter_path = clean_path(petitions_path(:signatures => 10000, :only_path => false))
    @example_collection_limit_filter_path = clean_path(petitions_path(:limit => 10, :only_path => false))
  end

  def gallery
  end

  private
  def clean_path(path)
    path.gsub('%5B', '[').gsub('%5D', ']')
  end
end
