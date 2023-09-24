Rails.application.routes.draw do
  # Root route
  root 'users#home'

  # OAuth and signout routes
  get 'auth/:provider/callback', to: 'sessions#create'
  get 'signout', to: 'sessions#destroy', as: 'signout'

  # Admin dashboard route
  get 'admin_dashboard', to: 'users#admin_dashboard', as: 'admin_dashboard'
  get 'admin_checkin', to: 'users#admin_checkin', as: 'admin_checkin'
  

  # Users routes
  resources :users do
    post 'admin_checkin', on: :collection
    collection do
      put :grant_admin  # Action to grant admin status.
    end
  end

  # Events routes
  resources :events, only: [:index, :new, :create]
end

