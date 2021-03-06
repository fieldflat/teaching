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
  get "/questions/search_form" => "questions#search_form"
  get "/questions/search" => "questions#search"

  get "/follows/:following_id/show_following" => "follows#show_following"
  get "/follows/:followed_id/show_followed" => "follows#show_followed" 

  post "/users/create" => "users#create"
  post "/users/login" => "users#login"
  post "/users/logout" => "users#logout"
  patch "/users/:id/update" => "users#update"
  post "/users/:id/update" => "users#update"

  post "/questions/create" => "questions#create"
  patch "/questions/:qid/update" => "questions#update"
  #post "/questions/:qid/update" => "questions#update"
  post "/questions/:qid/destroy" => "questions#destroy"

  post "/answers/:qid/create" => "answers#create"
  post "/answers/:aid/destroy" => "answers#destroy"

  post "/likes/:post_id/create" => "likes#create"
  post "/likes/:post_id/destroy" => "likes#destroy"
  post "/likes/:post_id/show_create" => "likes#show_create"
  post "/likes/:post_id/show_destroy" => "likes#show_destroy"
  post "/likes/:post_id/:user_id/user_show_create" => "likes#user_show_create"
  post "/likes/:post_id/:user_id/user_show_destroy" => "likes#user_show_destroy"

  post "/goods/:aid/:qid/create" => "goods#create"
  post "/goods/:aid/:qid/destroy" => "goods#destroy"

  post "/follows/:followed_id/create" => "follows#create"
  post "/follows/:followed_id/destroy" => "follows#destroy"


end
