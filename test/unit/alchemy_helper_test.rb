require 'test_helper'

class AlchemyHelperTest < ActionView::TestCase

  def file_path(filename)
    "#{Rails.root}/test/unit/alchemy/data/#{filename}"
  end

  def setup
    @alchemyObj = AlchemyAPI.new();
    @alchemyObj.setAPIKey(AlchemyHelper::API_KEY);

    # Load a HTML document to analyze.
    @htmlFile = File.readlines(file_path('example.html')).map {|l| l.strip}
  end

  test 'author' do
    # Extract concept tags from a web URL.
    result = @alchemyObj.URLGetAuthor("http://www.politico.com/blogs/media/2012/02/detroit-news-ed-upset-over-romney-edit-115247.html");
    Rails.logger.info "AlchemyAPI result: #{result}"

    assert_raise RuntimeError do
      # Extract concept tags from a web URL.
      # Raises an error because it can't find the author.
      @alchemyObj.HTMLGetAuthor(@htmlFile, "http://www.nytimes.com/2013/05/25/business/global/beijing-signals-a-shift-on-economic-policy.html?hp&_r=0");
    end
  end
end
