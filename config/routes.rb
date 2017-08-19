Rails.application.routes.draw do

  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }

  devise_scope :user do
    get "users/sign_in", to: "users/sessions#new", as: :new_session
    get "users/sign_out", to: "users/sessions#destroy", as: :destroy_session
  end

  resources :recipes, except: [:index] do
    put "ratings", to: "recipe_ratings#update"
  end

  post "photos", to: "photos#create"

  get "all-recipes", to: "recipes#all_recipes"
  get "my-recipes", to: "recipes#my_recipes", as: :my_recipes

  get "tags", to: "tags#index", as: :tags

  put "menu-plans/:id", to: "menu_plans#update"

  root to: "recipes#all_recipes"

end
