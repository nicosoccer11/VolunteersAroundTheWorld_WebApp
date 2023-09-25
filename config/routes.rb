Rails.application.routes.draw do
  # Root route
  root 'users#home'

  # OAuth and signout routes
  get 'auth/:provider/callback', to: 'sessions#create'
  get 'signout', to: 'sessions#destroy', as: 'signout'

  # Admin dashboard route
  get 'admin_dashboard', to: 'users#admin_dashboard', as: 'admin_dashboard'
  get 'admin_checkin', to: 'users#admin_checkin', as: 'admin_checkin'
  post 'admin_checkin', to: 'users#admin_checkin'
  post 'add_admin', to: 'users#add_admin', as: 'admin_add_admin'
  get '/users/home', to: 'users#home', as: 'users_home'
  get '/events/index', to: 'events#index', as: 'events_index'
  get '/events/new', to: 'events#new', as: 'events_new'
  # Users routes
  resources :users do
    post 'add_admin', on: :collection
  end

  # Events routes
  resources :events, only: [:index, :new, :create]
end

