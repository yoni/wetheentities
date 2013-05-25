Wetheentities::Application.routes.draw do
  root :to => 'home#index'

  resources :petitions, only: [:show]
end
