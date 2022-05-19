Rails.application.routes.draw do
  root to: "home#index"

  resources :contents do
    resources :comments, only:[:create]
    get 'show', :to => 'contents#show'
  end
  #resources :relationships, only:[:create, :destroy]
  
  #tag機能
  resources :tags do
    resources :tag_users do
      member do
        get :move_higher
        get :move_lower
      end
    end
  end
  
  #ログイン機能
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
  
  #プロフィール用
  resources :users, only: [:edit, :update] do
    collection do
      get 'plofile/edit', :to => 'users#edit'
      put 'plofile', :to => 'users#update' 
    end
  end
  
  #フォロー用
  resources :users do
    resource :relationships, only:[:create, :destroy]
    get 'followings' => 'relationships#followings', as: 'followings'
    get 'followers' => 'relationships#followers', as: 'followers'
    get 'profile', :to => 'users#profile'
  end
  
  #いいね機能
  post 'like/:id' => 'likes#create', as: 'create_like'
  delete 'like/:id' => 'likes#destroy', as: 'destroy_like'
  
end
