Prelaunchr::Application.routes.draw do

  ActiveAdmin.routes(self)

  devise_for :admin_users, ActiveAdmin::Devise.config

  root :to => "users#new"

  post 'users/create' => 'users#create'
  post 'save_image' , :to => redirect('/save_image.php')
  get 'refer-a-friend' => 'users#refer'
  get 'privacy-policy' => 'users#policy'
  get 'customise' => 'users#customise'
  authenticate :admin_user do
    get 'dashboard' => 'users#dashboard'
  end
  
  
  resources :users do
    member do
      get :confirm_email
    end
  end
  
  resources :orders

  unless Rails.application.config.consider_all_requests_local
    get '*not_found', to: 'users#redirect', :format => false
  end
end
