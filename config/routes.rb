Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root "home#index"
  get "/users/new" => "users#new"
  get "/users/login_form" => "users#login_form"
  get "/users/:id/show" => "users#show"
  get "/users/:id/edit" => "users#edit"

  post "/users/create" => "users#create"
  post "/users/login" => "users#login"
  post "/users/logout" => "users#logout"
  post "/users/:id/update" => "users#update"

end
