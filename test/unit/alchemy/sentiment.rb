

# Load the AlchemyAPI ruby code.
require "../module/AlchemyAPI.rb"


# Create an AlchemyAPI object.
alchemyObj = AlchemyAPI.new();


# Load the API key from disk.
alchemyObj.loadAPIKey("api_key.txt");


# Get sentiment for a web URL.
result = alchemyObj.URLGetTextSentiment("http://www.techcrunch.com/");
puts result


# Get sentiment for a text string.
result = alchemyObj.TextGetTextSentiment("I do enjoy a good cheeseburger.");
puts result


# Load a HTML document to analyze.
htmlFile = File.readlines('data/example.html').map {|l| l.strip}


# Get sentiment for a HTML document.
result = alchemyObj.HTMLGetTextSentiment(htmlFile, "http://www.test.com/");
puts result


# Create a parameters object.
eparamObj = AlchemyAPI_NamedEntityParams.new();

# Enable entity-targeted sentiment.
eparamObj.setSentiment(1);

# Retrieve named entities with entity-targeted sentiment.
result = alchemyObj.TextGetRankedNamedEntities("Mr. Miagi is the best sensei of all time.", AlchemyAPI::OutputMode::XML, eparamObj);
puts result


# Create a parameters object.
kparamObj = AlchemyAPI_KeywordParams.new();

# Enable keyword-targeted sentiment.
kparamObj.setSentiment(1);

# Retrieve keywords with keyword-targeted sentiment.
result = alchemyObj.TextGetRankedKeywords("Mr. Miagi is the best sensei of all time.", AlchemyAPI::OutputMode::XML, kparamObj);
puts result

#Create a targeted sentiment parameters object.
tsparamObj = AlchemyAPI_TargetedSentimentParams.new();
#Enable Show source text
tsparamObj.setShowSourceText(1);

# Retrieve targeted sentiment
result = alchemyObj.TextGetTargetedSentiment("This car is terrible.", "car", AlchemyAPI::OutputMode::XML, tsparamObj);
puts result

# Retrieve targeted sentiment
result = alchemyObj.URLGetTargetedSentiment("http://techcrunch.com/2012/03/01/keen-on-anand-rajaraman-how-walmart-wants-to-leapfrog-over-amazon-tctv/", "Walmart", AlchemyAPI::OutputMode::XML, tsparamObj);
puts result

# Retrieve targeted sentiment
result = alchemyObj.HTMLGetTargetedSentiment(htmlFile, "http://www.test.com/", "Votto", AlchemyAPI::OutputMode::XML, tsparamObj);
puts result

