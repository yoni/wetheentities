

# Load the AlchemyAPI ruby code.
require "../module/AlchemyAPI.rb"


# Create an AlchemyAPI object.
alchemyObj = AlchemyAPI.new();


# Load the API key from disk.
alchemyObj.loadAPIKey("api_key.txt");


# Extract Microformats from a web URL.
result = alchemyObj.URLGetMicroformats("http://microformats.org/wiki/hcard");
puts result


# Load a HTML document to analyze.
htmlFile2 = File.readlines('data/microformats.html').map {|l| l.rstrip}


# Extract Microformats from a HTML document.
result = alchemyObj.HTMLGetMicroformats(htmlFile2, "http://www.test.com/");
puts result


