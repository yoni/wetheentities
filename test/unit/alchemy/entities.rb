

# Load the AlchemyAPI ruby code.
require "../module/AlchemyAPI.rb"


# Create an AlchemyAPI object.
alchemyObj = AlchemyAPI.new();


# Load the API key from disk.
alchemyObj.loadAPIKey("api_key.txt");


# Extract a ranked list of named entities from a web URL.
result = alchemyObj.URLGetRankedNamedEntities("http://www.techcrunch.com/");
puts result


# Extract a ranked list of named entities from a text string.
result = alchemyObj.TextGetRankedNamedEntities("Hello my name is Bob.  I am speaking to you at this very moment.  Are you listening to me, Bob?");
puts result


# Load a HTML document to analyze.
htmlFile = File.readlines('data/example.html').map {|l| l.rstrip}


# Extract a ranked list of named entities from a HTML document.
result = alchemyObj.HTMLGetRankedNamedEntities(htmlFile, "http://www.test.com/");
puts result


