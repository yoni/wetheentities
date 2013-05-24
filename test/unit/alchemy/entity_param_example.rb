

# Load the AlchemyAPI ruby code.
require "../module/AlchemyAPI.rb"


# Create an AlchemyAPI object.
alchemyObj = AlchemyAPI.new();


# Load the API key from disk.
alchemyObj.loadAPIKey("api_key.txt");


# Create a parameters object.
paramObj = AlchemyAPI_NamedEntityParams.new();


# Turn off quotations extraction.
paramObj.setQuotations(0);


# Turn off entity disambiguation.
paramObj.setDisambiguate(0);


# Turn on sentiment extraction.
paramObj.setSentiment(1);


# Extract a ranked list of named entities from a web URL, using the parameters object.
result = alchemyObj.URLGetRankedNamedEntities("http://www.techcrunch.com/", AlchemyAPI::OutputMode::XML, paramObj);
puts result

# Extract a ranked list of named entities from a text string, using the parameters object.
result = alchemyObj.TextGetRankedNamedEntities("Hello my name is Bob.  I am speaking to you at this very moment.  Are you listening to me, Bob?", AlchemyAPI::OutputMode::XML, paramObj);
puts result


# Load a HTML document to analyze.
htmlFile = File.readlines('data/example.html').map {|l| l.rstrip}


# Extract a ranked list of named entities from a HTML document, using the parameters object.
result = alchemyObj.HTMLGetRankedNamedEntities(htmlFile, "http://www.test.com/", AlchemyAPI::OutputMode::XML, paramObj);
puts result


