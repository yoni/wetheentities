## We the Entities

We the Entities is a RESTful web service for augmenting the We the People petition text with rich entities, sentiment
analysis, and more.

#### See it in action

http://wetheentities.herokuapp.com/

#### About
We the Entities is being developed as part of the [National Day of Civic Hacking event at the
White House](http://www.whitehouse.gov/developers/apply-national-day-civic-hacking-white-house). It leverages the
[We the People API](https://petitions.whitehouse.gov/developers) to access petition data.

Contributors:

* [Yoni Ben-Meshulam](https://github.com/yoni)
* [Alec Turnbull](https://github.com/alecturnbull)

#### Contributing

To contribute, fork the application on github.com and send [Yoni Ben-Meshulam](https://github.com/yoni) a pull request. :)

We the Entities is a [Ruby on Rails](http://rubyonrails.org/) application.

##### Configuring API Keys

It relies on several APIs in order to work, including:
* Semantria
* Open Calais
* AlchemyAPI

In order to run the application on a local environment, you must set API keys for all three services:

    ALCHEMY_API_KEY=ABC123
    OPEN_CALAIS_LICENSE_ID=ABC123
    SEMANTRIA_CONSUMER_KEY=ABD123
    SEMANTRIA_CONSUMER_SECRET=DEF456
