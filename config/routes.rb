require 'sidekiq/web'

Wetheentities::Application.routes.draw do
  get 'examples/index'
  get 'examples/sentiment'
  get 'examples/geo'

  get 'api', :to => 'home#api'
  get 'about', :to => 'home#about'
  get 'gallery', :to => 'home#gallery'
  get 'petitions', :to => 'petitions#index'
  root :to => 'home#index'

  resources :petitions, only: [:show, :index]

  Sidekiq::Web.use Rack::Auth::Basic do |username, password|
    username == ENV['SIDEKIQ_WEB_USER'] && password == ENV['SIDEKIQ_WEB_PASSWORD']
  end

  mount Sidekiq::Web, at: '/sidekiq'
end
