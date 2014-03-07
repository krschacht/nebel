Bfsu::Application.routes.draw do

  root "topics#index"

  resources :topics
  resources :exercises

end
