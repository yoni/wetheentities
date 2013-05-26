## We the Entities

We the Entities is a RESTful web service for augmenting the [We the People](https://petitions.whitehouse.gov/) petition
text with rich entities, sentiment analysis, and more.

#### Live instance of the app

http://wetheentities.herokuapp.com/

#### About
We the Entities is being developed as part of the [National Day of Civic Hacking event at the
White House](http://www.whitehouse.gov/developers/apply-national-day-civic-hacking-white-house). It leverages the
[We the People API](https://petitions.whitehouse.gov/developers) to access petition data.

Contributors:

* [Yoni Ben-Meshulam](https://github.com/yoni)
* [Alec Turnbull](https://github.com/alecturnbull)

#### Contributing

To contribute, fork the application on Github and send [Yoni Ben-Meshulam](https://github.com/yoni) a pull request.

We the Entities is a [Ruby on Rails](http://rubyonrails.org/) application.

#### Issues

To report problems, ask questions, track enhancements, etc. please use Github [issues](https://github.com/yoni/wetheentities/issues).

##### Configuring API Keys

We the Entities relies on several external APIs in order to work, including:
* [Semantria](https://semantria.com/)
* [Open Calais](http://www.opencalais.com/)
* AlchemyAPI

In order to run the application on a local environment, you must set API keys for all three services:

    ALCHEMY_API_KEY=ABC123
    OPEN_CALAIS_LICENSE_ID=ABC123
    SEMANTRIA_CONSUMER_KEY=ABD123
    SEMANTRIA_CONSUMER_SECRET=DEF456


#### License

This software is distributed under the MIT License. For more information, see LICENSE
