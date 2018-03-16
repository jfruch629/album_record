Rails.application.routes.draw do
  devise_for :users

  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end

  resources :albums do
    resources :reviews, only: [:index, :new, :create, :edit, :update, :destroy]
  end

  namespace :admin do
    resources :users
    resources :albums
    resources :reviews
  end

  match 'reviews/:id' => 'reviews#destroy', :via => :delete, :as => :admin_destroy_review

  root 'albums#index'
    # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
