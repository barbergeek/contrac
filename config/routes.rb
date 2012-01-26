Contrac::Application.routes.draw do

  resources :tasks

  get "reports/select"
  post "reports/generate"
  get "reports/display"

  get "admin", :to => "admin#index"
  get "admin/notify"
  get "admin/scrape_news"
  get "admin/get_export"

  resources :companies
  resources :announcements

  resources :issues

  match "/login" => "sessions#new", :as => :login
  match "/logout" => "sessions#destroy", :as => :logout

  resources :sessions, :only => [:new, :create, :destroy]

  resources :users do
    collection do
      post 'become'
    end
  end

  resources :comments
  resources :tasks do
    member do
      delete 'cancel'
    end
  end
  resources :settings

  match "/about" => "pages#about"
  match "/help" => 'pages#help'
  match "/contact" => 'pages#contact'
  match "/home" => 'pages#home'

  match "/delayed_job" => DelayedJobWeb, :anchor => false

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
    resources :tasks
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

