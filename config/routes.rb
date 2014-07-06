Rails.application.routes.draw do
  
  devise_for :users
  
  devise_scope :user do
    get "users/:id/edit", to: "users/registrations#edit", as: :edit_user_registration
    put "users/:id", to: "users/registrations#update", as: :user_registration
  end
  
  resources :recipes
  
  root to: "recipes#index"
  
end
