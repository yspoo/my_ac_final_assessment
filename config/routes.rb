Rails.application.routes.draw do

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" } do
    delete 'sign_out', :to => 'devise/sessions#destroy', :as => :destroy_user_session
  end

  authenticated :user do
    root to: "users#home", as: :authenticated_user_homepage # only show the users that current user follows.
  end

  root to: "users#index"  # show all users

  resources :users do
    member do
      get :following, :followers
    end
  end

  resources :notes

  resources :relationships, only: [:create, :destroy]

end

# The order of the routes matter. Always put the authenticated root route BEFORE the non authenticated root route (since I want to show the non authenticated root page as the default root page and only redirect to the authenticated root page after signing in as a user.)
