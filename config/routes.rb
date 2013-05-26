Wetheentities::Application.routes.draw do
  get "examples/sentiment"

  get "examples/geo"

  root :to => 'home#index'

  resources :petitions, only: [:show]
end
