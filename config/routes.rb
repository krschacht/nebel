Nebel::Application.routes.draw do

  root "welcome#index"

  get    "/topics"              => "topics#index",    as: "topics"
  get    "/topics/new"          => "topics#new",      as: "new_topic"
  get    "/topics/:id/edit"     => "topics#edit",     as: "edit_topic"
  get    "/topics/:slug"        => "topics#show",     as: "canonical_topic"
  post   "/topics"              => "topics#create"
  post   "/topics/:id/complete" => "topics#complete", as: "complete_topic"
  patch  "/topics/:id"          => "topics#update",   as: "topic"

  get    "/exercises/new"      => "exercises#new",    as: "new_exercise"
  get    "/exercises/:id/edit" => "exercises#edit",   as: "edit_exercise"
  post   "/exercises"          => "exercises#create", as: "exercises"
  patch  "/exercises/:id"      => "exercises#update", as: "exercise"

  get    "/materials"          => "materials#index",  as: "materials"
  get    "/materials/new"      => "materials#new",    as: "new_material"
  get    "/materials/:id/edit" => "materials#edit",   as: "edit_material"
  post   "/materials"          => "materials#create"
  post   "/materials/merge"    => "materials#merge",  as: "merge_materials"
  patch  "/materials/:id"      => "materials#update", as: "material"
  delete "/materials/:id"      => "materials#destroy"

  post   "/requisitions"     => "requisitions#create", as: "requisitions"
  patch  "/requisitions/:id" => "requisitions#update", as: "requisition"
  delete "/requisitions/:id" => "requisitions#destroy"

  get    "/messages"            => "messages#index",  as: "messages"
  get    "/messages/:id"        => "messages#show",   as: "message"
  post   "/messages"            => "messages#create"
  patch  "/messages/:id/toggle" => "messages#toggle", as: "toggle_message"
  delete "/messages/:id"        => "messages#destroy"

  get   "/users/new"               => "users#new",               as: "new_user"
  get   "/users/:id/edit"          => "users#edit",              as: "edit_user"
  get   "/users/forgot_password"   => "users#forgot_password",   as: "forgot_password_users"
  post  "/users"                   => "users#create",            as: "users"
  post  "/users/send_access_email" => "users#send_access_email", as: "send_access_email_users"
  patch "/users/:id"               => "users#update",            as: "user"

  get    "/sessions/new" => "sessions#new",    as: "new_session"
  post   "/sessions"     => "sessions#create", as: "sessions"
  delete "/sessions/"    => "sessions#destroy"

  get    "/subscriptions/new" => "subscriptions#new",    as: "new_subscription"
  post   "/subscriptions"     => "subscriptions#create", as: "subscriptions"
  patch  "/subscriptions"     => "subscriptions#update"
  delete "/subscriptions"     => "subscriptions#destroy"

  post "/webhooks/stripe" => "webhooks#stripe"

  post "/markdown/preview", to: "markdown#preview"

end
