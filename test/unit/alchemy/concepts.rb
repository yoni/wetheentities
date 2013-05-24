

# Load the AlchemyAPI ruby code.
require "../module/AlchemyAPI.rb"


# Create an AlchemyAPI object.
alchemyObj = AlchemyAPI.new();


# Load the API key from disk.
alchemyObj.loadAPIKey("api_key.txt");


# Extract concept tags from a web URL.
result = alchemyObj.URLGetRankedConcepts("http://www.techcrunch.com/");
puts result


# Extract concept tags from a text string.
result = alchemyObj.TextGetRankedConcepts("This thing has a steering wheel, tires, and an engine.  Do you know what it is?");
puts result


# Load a HTML document to analyze.
htmlFile = File.readlines('data/example.html').map {|l| l.rstrip}


# Extract concept tags from a HTML document.
result = alchemyObj.HTMLGetRankedConcepts(htmlFile, "http://www.test.com/");
puts result


