Rails.application.routes.draw do


  resources :contents


  
  devise_for :users, controllers: { registrations: 'users/registrations' }
  
  root to: "home#index"
  get 'users/show' => 'users#show' 
end
