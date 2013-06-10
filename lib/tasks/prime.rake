namespace :cache do
  desc 'Primes the cache of petition analyses.'
  task :prime => :environment do
    petitions = WeThePeople::Resources::Petition.cursor.get_all
    petitions.each {|petition|
      Petition.find(petition)
    }
  end
end
