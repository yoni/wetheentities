Wetheentities::Application.routes.draw do
  get 'examples/index'
  get 'examples/sentiment'
  get 'examples/geo'

  get 'api', :to => 'home#api'
  get 'about', :to => 'home#about'
  get 'petitions', :to => 'petitions#index'
  root :to => 'home#index'

  resources :petitions, only: [:show, :index]
end
