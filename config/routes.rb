Bfsu::Application.routes.draw do

  root "welcome#index"

  resources :subscriptions, only: [:new, :create] do
    patch :update, on: :collection
    delete :destroy, on: :collection
  end
  resources :requisitions, only: [:create, :update, :destroy]
  resources :users, only: [:new, :edit, :update, :create] do
    get :forgot_password, on: :collection
    post :send_access_email, on: :collection
  end
  resources :topics,    except: :show
  resources :exercises, except: [:index, :show]
  resources :messages, only: [:show, :index, :create, :destroy] do
    patch :toggle, on: :member
  end
  resources :sessions, only: [:new, :create] do
    delete :destroy, on: :collection
  end
  resources :materials, except: :show do
    post :merge, on: :collection
  end

  post "/webhooks/stripe" => "webhooks#stripe"

  get "/topics/:slug", to: "topics#show", as: "canonical_topic"

  post "/markdown/preview", to: "markdown#preview"

end
