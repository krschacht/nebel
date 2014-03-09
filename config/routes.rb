Bfsu::Application.routes.draw do

  root "topics#index"

  resources :topics,    except: :show
  resources :exercises, except: [:index, :show]

  get "/topics/:topic_slug/part-:order", to: "exercises#show", as: "canonical_exercise"
  get "/topics/:slug(/:field)", to: "topics#show", as: "canonical_topic", defaults: { field: "overview" }


end
