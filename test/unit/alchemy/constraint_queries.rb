

# Load the AlchemyAPI ruby code.
require "../module/AlchemyAPI.rb"


# Create an AlchemyAPI object.
alchemyObj = AlchemyAPI.new();


# Load the API key from disk.
alchemyObj.loadAPIKey("api_key.txt");


# Extract first link from an URL.
result = alchemyObj.URLGetConstraintQuery("http://microformats.org/wiki/hcard", "1st link");
puts result


# Load a HTML document to analyze.
htmlFile = File.readlines('data/example.html').map {|l| l.rstrip}


# Extract first link from a HTML.
result = alchemyObj.HTMLGetConstraintQuery(htmlFile, "http://www.test.com/", "1st link");
puts result
