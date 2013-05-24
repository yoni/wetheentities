

# Load the AlchemyAPI ruby code.
require "../module/AlchemyAPI.rb"


# Create an AlchemyAPI object.
alchemyObj = AlchemyAPI.new();


# Load the API key from disk.
alchemyObj.loadAPIKey("api_key.txt");


# Extract a title from a web URL.
result = alchemyObj.URLGetTitle("http://www.techcrunch.com/");
puts result


# Extract page text from a web URL (ignoring navigation links, ads, etc.).
result = alchemyObj.URLGetText("http://www.techcrunch.com/");
puts result


# Extract raw page text from a web URL (including navigation links, ads, etc.).
result = alchemyObj.URLGetRawText("http://www.techcrunch.com/");
puts result


# Load a HTML document to analyze.
htmlFile = File.readlines('data/example.html').map {|l| l.rstrip}


# Extract a title from a HTML document.
result = alchemyObj.HTMLGetTitle(htmlFile, "http://www.test.com/");
puts result


# Extract page text from a HTML document (ignoring navigation links, ads, etc.).
result = alchemyObj.HTMLGetText(htmlFile, "http://www.test.com/");
puts result


# Extract raw page text from a HTML document (including navigation links, ads, etc.).
result = alchemyObj.HTMLGetRawText(htmlFile, "http://www.test.com/");
puts result


