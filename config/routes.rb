Bfsu::Application.routes.draw do

  root "topics#index"

  get "/topics/:topic_id/part-:order", to: "exercises#show", as: "canonical_exercise"
  get "/topics/:id(/:field)", to: "topics#show", as: "canonical_topic", defaults: { field: "overview" }

  resources :topics
  resources :exercises

end
