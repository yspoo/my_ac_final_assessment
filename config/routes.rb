Rails.application.routes.draw do

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" } do
    delete 'sign_out', :to => 'devise/sessions#destroy', :as => :destroy_user_session
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: "users#index"  # show all users

  authenticated :user do
    root to: "users#home", as: :authenticated_user_homepage # only show the users that current user follows.
  end

  resources :users do
    member do
      get :following, :followers
    end
  end

  resources :notes

end
