Rails.application.routes.draw do

  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }

  devise_scope :user do
    get "users/sign_in", to: "users/sessions#new", as: :new_session
    get "users/sign_out", to: "users/sessions#destroy", as: :destroy_session
  end

  resources :recipes do
    put "ratings", to: "recipe_ratings#update"
  end

  root to: "recipes#index"

end
