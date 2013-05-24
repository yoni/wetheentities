

# Load the AlchemyAPI ruby code.
require "../module/AlchemyAPI.rb"


# Create an AlchemyAPI object.
alchemyObj = AlchemyAPI.new();


# Load the API key from disk.
alchemyObj.loadAPIKey("api_key.txt");


# Extract a ranked list of relations from a web URL.
result = alchemyObj.URLGetRelations("http://www.techcrunch.com/");
puts result


# Extract a ranked list of relations from a text string.
result = alchemyObj.TextGetRelations("Hello my name is Bob.  I am speaking to you at this very moment.  Are you listening to me, Bob?");
puts result


# Load a HTML document to analyze.
htmlFile = File.readlines('data/example.html').map {|l| l.rstrip}


# Extract a ranked list of relations from a HTML document.
result = alchemyObj.HTMLGetRelations(htmlFile, "http://www.test.com/");
puts result


paramObj = AlchemyAPI_RelationParams.new();
paramObj.setSentiment(1);
paramObj.setEntities(1);
paramObj.setDisambiguate(1);
paramObj.setSentimentExcludeEntities(1);

result = alchemyObj.TextGetRelations("Madonna enjoys tasty Pepsi.  I love her style.", AlchemyAPI::OutputMode::XML, paramObj);
puts result

paramObj.setRequireEntities(1);
result = alchemyObj.TextGetRelations("Madonna enjoys tasty Pepsi.  I love her style.", AlchemyAPI::OutputMode::XML, paramObj);
puts result