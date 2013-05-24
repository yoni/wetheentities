

# Load the AlchemyAPI ruby code.
require "../module/AlchemyAPI.rb"


# Create an AlchemyAPI object.
alchemyObj = AlchemyAPI.new();


# Load the API key from disk.
alchemyObj.loadAPIKey("api_key.txt");


# Categorize a web URL.
result = alchemyObj.URLGetCategory("http://www.techcrunch.com/");
puts result


# Categorize some text.
result = alchemyObj.TextGetCategory("Latest on the War in Iraq.");
puts result


# Load a HTML document to analyze.
htmlFile = File.readlines('data/example.html').map {|l| l.rstrip}


# Categorize a HTML document.
result = alchemyObj.HTMLGetCategory(htmlFile, "http://www.test.com/");
puts result


