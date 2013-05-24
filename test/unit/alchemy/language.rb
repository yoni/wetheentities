

# Load the AlchemyAPI ruby code.
require "../module/AlchemyAPI.rb"


# Create an AlchemyAPI object.
alchemyObj = AlchemyAPI.new();


# Load the API key from disk.
alchemyObj.loadAPIKey("api_key.txt");


# Detect the language for a web URL.
result = alchemyObj.URLGetLanguage("http://www.techcrunch.fr/");
puts result


# Detect the language for a text string. (requires at least 100 characters text)
result = alchemyObj.TextGetLanguage("Hello my name is Bob Jones.  I am speaking to you at this very moment.  Are you listening to me, Bob?");
puts result


# Load a HTML document to analyze.
htmlFile = File.readlines('data/example.html').map {|l| l.rstrip}


# Detect the language for a HTML document.
result = alchemyObj.HTMLGetLanguage(htmlFile, "http://www.test.com/");
puts result


