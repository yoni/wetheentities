

# Load the AlchemyAPI ruby code.
require "../module/AlchemyAPI.rb"
require 'iconv'


# Create an AlchemyAPI object.
alchemyObj = AlchemyAPI.new();


# Load the API key from disk.
alchemyObj.loadAPIKey("api_key.txt");

# Extract a title from a web URL.
result = alchemyObj.URLGetRankedKeywords("http://www.techcrunch.com/", AlchemyAPI::OutputMode::RDF);
puts result


# Load a HTML document to analyze.
htmlFile = File.readlines('data/example.html').map {|l| l.rstrip}

# Categorize a HTML document.
result = alchemyObj.HTMLGetCategory(htmlFile, "http://www.test.com/", AlchemyAPI::OutputMode::JSON);
puts result

# Extract first link from an URL.
result = alchemyObj.URLGetConstraintQuery("http://microformats.org/wiki/hcard", "1st link", AlchemyAPI::OutputMode::JSON);
puts result

# Extract RSS / ATOM feed links from a HTML document.
result = alchemyObj.HTMLGetFeedLinks(htmlFile, "http://www.test.com/", AlchemyAPI::OutputMode::JSON);
puts result

# Extract topic keywords from a text string.
result = alchemyObj.TextGetRankedKeywords("Hello my name is Bob Jones.  I am speaking to you at this very moment.  Are you listening to me, Bob?", AlchemyAPI::OutputMode::JSON);
puts result
