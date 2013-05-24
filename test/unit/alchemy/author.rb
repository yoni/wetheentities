

# Load the AlchemyAPI ruby code.
require "../module/AlchemyAPI.rb"


# Create an AlchemyAPI object.
alchemyObj = AlchemyAPI.new();


# Load the API key from disk.
alchemyObj.loadAPIKey("api_key.txt");


# Load a HTML document to analyze.
 htmlFile = File.readlines('data/example.html').map {|l| l.strip}


# Extract concept tags from a web URL.
result = alchemyObj.URLGetAuthor("http://www.politico.com/blogs/media/2012/02/detroit-news-ed-upset-over-romney-edit-115247.html");
puts result

# Extract concept tags from a web URL.
result = alchemyObj.HTMLGetAuthor(htmlFile, "http://www.test.com/");
puts result
