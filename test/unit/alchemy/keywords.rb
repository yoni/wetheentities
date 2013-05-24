

# Load the AlchemyAPI ruby code.
require "../module/AlchemyAPI.rb"


# Create an AlchemyAPI object.
alchemyObj = AlchemyAPI.new();


# Load the API key from disk.
alchemyObj.loadAPIKey("api_key.txt");


# Extract topic keywords from a web URL.
result = alchemyObj.URLGetRankedKeywords("http://www.techcrunch.com/");
puts result


# Extract topic keywords from a text string.
result = alchemyObj.TextGetRankedKeywords("Hello my name is Bob Jones.  I am speaking to you at this very moment.  Are you listening to me, Bob?");
puts result


# Load a HTML document to analyze.
htmlFile = File.readlines('data/example.html').map {|l| l.rstrip}


# Extract topic keywords from a HTML document.
result = alchemyObj.HTMLGetRankedKeywords(htmlFile, "http://www.test.com/");
puts result


