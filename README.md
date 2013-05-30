## We the Entities

We the Entities adds rich entities, sentiment analysis, and other text-based
analysis on petitions taken from the White House's [We the People](https://petitions.whitehouse.gov/)
application.

It provides a summary of the "entities" (e.g. people, places, organizations),
themes, and phrases from petitions. It also discerns the sentiment of the
author towards these entities (i.e. negative, neutral or positive).

We the Entities includes a petition browser and a Developer API.

Under the covers, We the Entities leverages text analysis services like Open Calais, AlchemyAPI, and Semantria
to extract information from the petition title and body.

#### See the live instance of the app for examples

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

#### Notes on local development

##### Configuring API Keys

We the Entities relies on several external APIs in order to work, including:
* [Semantria](https://semantria.com/)
* [Open Calais](http://www.opencalais.com/)
* [AlchemyAPI](http://www.alchemyapi.com/)

In order to run the application on a local environment, you must set API keys for all three services:

    ALCHEMY_API_KEY=ABC123
    OPEN_CALAIS_LICENSE_ID=ABC123
    SEMANTRIA_CONSUMER_KEY=ABD123
    SEMANTRIA_CONSUMER_SECRET=DEF456

##### Configuring Redis

We the Entities uses a Redis store for job queueing and caching. To configure the Redis server, set:

    REDISTOGO_URL

If not set, a default Redis URL will be used:

    redis://127.0.0.1:6379/0/wetheentities

This default should work on a standard Redis install, for example on OS X:

    brew install redis
    redis-server /usr/local/etc/redis.conf

##### Starting sidekiq

We the Entities uses the `sidekiq` Ruby gem for background workers to run semantic analysis. In order
to start background workers for a local install, run:

    sidekiq -q high,5 default

##### See also
http://railscasts.com/episodes/366-sidekiq

##### Process for running locally

1. Start Redis

    redis-server /usr/local/etc/redis.conf

2. Start sidekiq

    foreman run bundle exec sidekiq -q high,5 default

3. Start Rails server

    foreman run rails server

#### License

This software is distributed under the MIT License. For more information, see LICENSE
