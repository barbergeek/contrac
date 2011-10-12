Contrac::Application.routes.draw do

  get "admin", :to => "admin#index"
  get "admin/notify"

  resources :companies

  resources :announcements

  match "/login" => "sessions#new", :as => :login
  match "/logout" => "sessions#destroy", :as => :logout
  
  resources :sessions, :only => [:new, :create, :destroy]
  
  resources :users do
    collection do
      post 'become'
    end
  end

  resources :comments

  match "/about" => "pages#about"
  match "/help" => 'pages#help'
  match "/contact" => 'pages#contact'
#  match "/users" => 'user#index'

  resources :opportunities do
    collection do
      post 'filter','calendar_order_by'
      get 'my', 'calendar', 'all', 'dashboard','export'
    end
    member do
      post 'watch', 'own'
    end
    resources :comments
  end

  resources :input_records, :only => [:index, :show, :edit, :update, :destroy] do
    collection do
      get 'import'
      post 'upload'
      put 'merge'
    end
  end

  root :to => "pages#home"

end

