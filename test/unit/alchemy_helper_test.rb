require 'test_helper'

class AlchemyHelperTest < ActionView::TestCase

  TECH_CRUNCH_URL = 'http://www.techcrunch.com/'
  TEST_URL = 'http://www.test.com/'
  MICROFORMATS_URL = 'http://microformats.org/wiki/hcard'
  STRING_WITH_NAMES_ENTITIES = "Hello my name is Bob.  I am speaking to you at this very moment.  Are you listening to me, Bob?"

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
      @alchemyObj.HTMLGetAuthor(@htmlFile, TEST_URL);
    end
  end

  test 'categories' do
    # Categorize a web URL.
    result = @alchemyObj.URLGetCategory(TECH_CRUNCH_URL);
    assert_not_nil result

    # Categorize some text.
    result = @alchemyObj.TextGetCategory("Latest on the War in Iraq.");
    assert_not_nil result

    # Categorize a HTML document.
    result = @alchemyObj.HTMLGetCategory(@htmlFile, TEST_URL);
    assert_not_nil result
  end

  test 'concepts' do
    # Extract concept tags from a web URL.
    result = @alchemyObj.URLGetRankedConcepts(TECH_CRUNCH_URL);
    assert_not_nil result


    # Extract concept tags from a text string.
    result = @alchemyObj.TextGetRankedConcepts("This thing has a steering wheel, tires, and an engine.  Do you know what it is?");
    assert_not_nil result

    # Extract concept tags from a HTML document.
    result = @alchemyObj.HTMLGetRankedConcepts(@htmlFile, TEST_URL);
    assert_not_nil result
  end


  test 'constraint queries' do
    # Extract first link from an URL.
    result = @alchemyObj.URLGetConstraintQuery(MICROFORMATS_URL, "1st link");
    assert_not_nil result

    assert_raise RuntimeError do
      # Extract first link from a HTML.
      result = @alchemyObj.HTMLGetConstraintQuery(@htmlFile, TEST_URL, "1st link");
      assert_not_nil result
    end
  end

  test 'entities' do
    # Extract a ranked list of named entities from a web URL.
    result = @alchemyObj.URLGetRankedNamedEntities(TECH_CRUNCH_URL);
    assert_not_nil result


    # Extract a ranked list of named entities from a text string.
    result = @alchemyObj.TextGetRankedNamedEntities(STRING_WITH_NAMES_ENTITIES);
    assert_not_nil result

    # Extract a ranked list of named entities from a HTML document.
    result = @alchemyObj.HTMLGetRankedNamedEntities(@htmlFile, TEST_URL);
    assert_not_nil result
  end

  test 'entity params' do

    # Create a parameters object.
    paramObj = AlchemyAPI_NamedEntityParams.new();

    # Turn off quotations extraction.
    paramObj.setQuotations(0);

    # Turn off entity disambiguation.
    paramObj.setDisambiguate(0);

    # Turn on sentiment extraction.
    paramObj.setSentiment(1);

    # Extract a ranked list of named entities from a web URL, using the parameters object.
    result = @alchemyObj.URLGetRankedNamedEntities(TECH_CRUNCH_URL, AlchemyAPI::OutputMode::XML, paramObj);
    assert_not_nil result

    # Extract a ranked list of named entities from a text string, using the parameters object.
    result = @alchemyObj.TextGetRankedNamedEntities(STRING_WITH_NAMES_ENTITIES, AlchemyAPI::OutputMode::XML, paramObj);
    assert_not_nil result

    # Extract a ranked list of named entities from a HTML document, using the parameters object.
    result = @alchemyObj.HTMLGetRankedNamedEntities(@htmlFile, TEST_URL, AlchemyAPI::OutputMode::XML, paramObj);
    assert_not_nil result
  end

  test 'feed links' do
    # Extract RSS / ATOM feed links from a web URL.
    result = @alchemyObj.URLGetFeedLinks(TECH_CRUNCH_URL);
    assert_not_nil result

    # Extract RSS / ATOM feed links from a HTML document.
    result = @alchemyObj.HTMLGetFeedLinks(@htmlFile, TEST_URL);
    assert_not_nil result
  end

  test 'json_example' do
    # Extract a title from a web URL.
    result = @alchemyObj.URLGetRankedKeywords(TECH_CRUNCH_URL, AlchemyAPI::OutputMode::RDF);
    assert_not_nil result

    # Categorize a HTML document.
    result = @alchemyObj.HTMLGetCategory(@htmlFile, TEST_URL, AlchemyAPI::OutputMode::JSON);
    assert_not_nil result

    # Extract first link from an URL.
    result = @alchemyObj.URLGetConstraintQuery(MICROFORMATS_URL, "1st link", AlchemyAPI::OutputMode::JSON);
    assert_not_nil result

    # Extract RSS / ATOM feed links from a HTML document.
    result = @alchemyObj.HTMLGetFeedLinks(@htmlFile, TEST_URL, AlchemyAPI::OutputMode::JSON);
    assert_not_nil result

    # Extract topic keywords from a text string.
    result = @alchemyObj.TextGetRankedKeywords("Hello my name is Bob Jones.  I am speaking to you at this very moment.  Are you listening to me, Bob?", AlchemyAPI::OutputMode::JSON);
    assert_not_nil result
  end

  test 'keywords' do
    # Extract topic keywords from a web URL.
    result = @alchemyObj.URLGetRankedKeywords(TECH_CRUNCH_URL);
    assert_not_nil result


    # Extract topic keywords from a text string.
    result = @alchemyObj.TextGetRankedKeywords(STRING_WITH_NAMES_ENTITIES);
    assert_not_nil result

    # Extract topic keywords from a HTML document.
    result = @alchemyObj.HTMLGetRankedKeywords(@htmlFile, TEST_URL);
    assert_not_nil result
  end

  test 'language' do
    result = @alchemyObj.URLGetLanguage("http://www.techcrunch.fr/");
    assert_not_nil result

    # Detect the language for a text string. (requires at least 100 characters text)
    result = @alchemyObj.TextGetLanguage(STRING_WITH_NAMES_ENTITIES);
    assert_not_nil result

    # Detect the language for a HTML document.
    result = @alchemyObj.HTMLGetLanguage(@htmlFile, TEST_URL);
    assert_not_nil result
  end

  test 'microformats' do
    # Extract Microformats from a web URL.
    result = @alchemyObj.URLGetMicroformats(MICROFORMATS_URL);
    assert_not_nil result
    # Extract Microformats from a HTML document.
    result = @alchemyObj.HTMLGetMicroformats(@htmlFile, TEST_URL);
    assert_not_nil result
  end

  test 'relations' do
    # Extract a ranked list of relations from a web URL.
    result = @alchemyObj.URLGetRelations(TECH_CRUNCH_URL);
    assert_not_nil result

    # Extract a ranked list of relations from a text string.
    result = @alchemyObj.TextGetRelations(STRING_WITH_NAMES_ENTITIES);
    assert_not_nil result

    # Extract a ranked list of relations from a HTML document.
    result = @alchemyObj.HTMLGetRelations(@htmlFile, TEST_URL);
    assert_not_nil result

    paramObj = AlchemyAPI_RelationParams.new();
    paramObj.setSentiment(1);
    paramObj.setEntities(1);
    paramObj.setDisambiguate(1);
    paramObj.setSentimentExcludeEntities(1);

    result = @alchemyObj.TextGetRelations("Madonna enjoys tasty Pepsi.  I love her style.", AlchemyAPI::OutputMode::XML, paramObj);
    assert_not_nil result

    paramObj.setRequireEntities(1);
    result = @alchemyObj.TextGetRelations("Madonna enjoys tasty Pepsi.  I love her style.", AlchemyAPI::OutputMode::XML, paramObj);
    assert_not_nil result
  end

  test 'sentiment' do

    # Get sentiment for a web URL.
    result = @alchemyObj.URLGetTextSentiment(TECH_CRUNCH_URL);
    assert_not_nil result


    # Get sentiment for a text string.
    result = @alchemyObj.TextGetTextSentiment("I do enjoy a good cheeseburger.");
    assert_not_nil result

    # Get sentiment for a HTML document.
    result = @alchemyObj.HTMLGetTextSentiment(@htmlFile, TEST_URL);
    assert_not_nil result

    # Create a parameters object.
    eparamObj = AlchemyAPI_NamedEntityParams.new();

    # Enable entity-targeted sentiment.
    eparamObj.setSentiment(1);

    # Retrieve named entities with entity-targeted sentiment.
    result = @alchemyObj.TextGetRankedNamedEntities("Mr. Miagi is the best sensei of all time.", AlchemyAPI::OutputMode::XML, eparamObj);
    assert_not_nil result


    # Create a parameters object.
    kparamObj = AlchemyAPI_KeywordParams.new();

    # Enable keyword-targeted sentiment.
    kparamObj.setSentiment(1);

    # Retrieve keywords with keyword-targeted sentiment.
    result = @alchemyObj.TextGetRankedKeywords("Mr. Miagi is the best sensei of all time.", AlchemyAPI::OutputMode::XML, kparamObj);
    assert_not_nil result

    #Create a targeted sentiment parameters object.
    tsparamObj = AlchemyAPI_TargetedSentimentParams.new();
    #Enable Show source text
    tsparamObj.setShowSourceText(1);

    # Retrieve targeted sentiment
    result = @alchemyObj.TextGetTargetedSentiment("This car is terrible.", "car", AlchemyAPI::OutputMode::XML, tsparamObj);
    assert_not_nil result

    # The Alchemy API has a bug with the targeted sentiment service. I reached out to their support folks.
    assert_raise RuntimeError do
      # Retrieve targeted sentiment
      result = @alchemyObj.URLGetTargetedSentiment("http://techcrunch.com/2012/03/01/keen-on-anand-rajaraman-how-walmart-wants-to-leapfrog-over-amazon-tctv/", "Walmart", AlchemyAPI::OutputMode::XML, tsparamObj);
      assert_not_nil result
    end

    # Retrieve targeted sentiment
    result = @alchemyObj.HTMLGetTargetedSentiment(@htmlFile, TEST_URL, "Votto", AlchemyAPI::OutputMode::XML, tsparamObj);
    assert_not_nil result
  end

  test 'text extract' do
    # Extract a title from a web URL.
    result = @alchemyObj.URLGetTitle(TECH_CRUNCH_URL);
    assert_not_nil result

    # Extract page text from a web URL (ignoring navigation links, ads, etc.).
    result = @alchemyObj.URLGetText(TECH_CRUNCH_URL);
    assert_not_nil result

    # Extract raw page text from a web URL (including navigation links, ads, etc.).
    result = @alchemyObj.URLGetRawText(TECH_CRUNCH_URL);
    assert_not_nil result

    # Extract a title from a HTML document.
    result = @alchemyObj.HTMLGetTitle(@htmlFile, TEST_URL);
    assert_not_nil result

    # Extract page text from a HTML document (ignoring navigation links, ads, etc.).
    result = @alchemyObj.HTMLGetText(@htmlFile, TEST_URL);
    assert_not_nil result

    # Extract raw page text from a HTML document (including navigation links, ads, etc.).
    result = @alchemyObj.HTMLGetRawText(@htmlFile, TEST_URL);
    assert_not_nil result
  end
end

