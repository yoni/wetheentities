

# Load the AlchemyAPI ruby code.
require "../module/AlchemyAPI.rb"


# Create an AlchemyAPI object.
alchemyObj = AlchemyAPI.new();


# Load the API key from disk.
alchemyObj.loadAPIKey("api_key.txt");


# Extract RSS / ATOM feed links from a web URL.
result = alchemyObj.URLGetFeedLinks("http://www.techcrunch.com/");
puts result


# Load a HTML document to analyze.
htmlFile = File.readlines('data/example.html').map {|l| l.rstrip}


# Extract RSS / ATOM feed links from a HTML document.
result = alchemyObj.HTMLGetFeedLinks(htmlFile, "http://www.test.com/");
puts result


