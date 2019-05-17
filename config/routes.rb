Rails.application.routes.draw do

  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }

  devise_scope :user do
    get "users/sign_in", to: "users/sessions#new", as: :new_session
    get "users/sign_out", to: "users/sessions#destroy", as: :destroy_session
  end

  resources :recipes, except: [:index] do
    put "ratings", to: "recipe_ratings#update"
    post "preparations", to: "recipe_preparations#create", as: :preparations
  end

  post "photos", to: "photos#create"

  get "all-recipes", to: "recipes#all_recipes", as: :all_recipes
  get "my-recipes", to: "recipes#my_recipes", as: :my_recipes

  get "tags", to: "tags#index", as: :tags

  get "history", to: "history#index", as: :history

  put "menu-plans/:id", to: "menu_plans#update"

  get "shopping-list", to: "menu_plans#shopping_list", as: :shopping_list

  root to: "recipes#all_recipes"

  direct :chrome_extension do
    "https://chrome.google.com/webstore/detail/add-to-lailrecipes/hcgmkgaknppcjpohhfnmkipmninochga"
  end

end
