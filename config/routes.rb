Wetheentities::Application.routes.draw do

  resources :petitions, only: [:show]
end
