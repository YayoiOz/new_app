Rails.application.routes.draw do

  resources :contents
  root to: "home#index"
  
  
  devise_for :users, :controllers => {
    :registrations => 'users/registrations',
    :sessions => 'users/sessions',
    :passwords => 'users/passwords',
    :confirmations => 'users/confirmations',
    :unlocks => 'users/unlocks'
    }
  devise_scope :user do
    get "signup", :to => "users/registrations#new"
    get "login", :to => "users/sessions#new"
    delete "logout", :to => "users/sessions#destroy"
  end
  
  resources :users, only: [:edit, :update] do
    collection do
      get 'mypage', :to => 'users#show'
      get 'mypage/edit', :to => 'users#edit'
      put 'mypage', :to => 'users#update' 
    end
  end
  
end
