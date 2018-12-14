Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root "home#index"
  get "/users/new" => "users#new"
  get "/users/login_form" => "users#login_form"
  get "/users/:id/show" => "users#show"
  get "/users/:id/edit" => "users#edit"

  get "/questions/new" => "questions#new"
  get "/questions/index" => "questions#index"
  get "/questions/:qid/edit" => "questions#edit"
  get "/questions/:qid/show" => "questions#show"

  post "/users/create" => "users#create"
  post "/users/login" => "users#login"
  post "/users/logout" => "users#logout"
  post "/users/:id/update" => "users#update"

  post "/questions/create" => "questions#create"
  post "/questions/:qid/update" => "questions#update"
  post "/questions/:qid/destroy" => "questions#destroy"

  post "/answers/:qid/create" => "answers#create"
  post "/answers/:aid/destroy" => "answers#destroy"

end
