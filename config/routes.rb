Rails.application.routes.draw do
  # Root route
  root 'users#admin_dashboard'

  # OAuth and signout routes
  get 'auth/:provider/callback', to: 'sessions#create'
  get 'signout', to: 'sessions#destroy', as: 'signout'

  # Admin dashboard route
  get 'admin_dashboard', to: 'users#admin_dashboard', as: 'admin_dashboard'
  get 'admin_checkin', to: 'users#admin_checkin', as: 'admin_checkin'
  post 'admin_checkin', to: 'users#admin_checkin'
  get '/users/home', to: 'users#home', as: 'users_home'
  get '/events/index', to: 'events#index', as: 'events_index'
  get '/events/new', to: 'events#new', as: 'events_new'
  # Users routes
  resources :users do
    collection do
      put :grant_admin  # Action to grant admin status.
    end
  end

  # Events routes
  resources :events, only: [:index, :new, :create]
end

