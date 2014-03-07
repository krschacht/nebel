Bfsu::Application.routes.draw do

  root "topics#index"

  get "/topics/:id(/:field)", to: "topics#show", as: "topic", defaults: { field: "overview" }

  resources :topics
  resources :exercises

end
