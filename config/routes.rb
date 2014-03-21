Bfsu::Application.routes.draw do

  root "welcome#index"

  delete "/requisitions", to: "requisitions#destroy", as: "requisition"

  resources :users
  resources :topics,    except: :show
  resources :exercises, except: [:index, :show]
  resources :materials, except: :show do
    post :merge, on: :collection
  end

  get "/topics/:topic_slug/part-:part", to: "exercises#show", as: "canonical_exercise"
  get "/topics/:slug(/:field)", to: "topics#show", as: "canonical_topic", defaults: { field: "overview" }

end
