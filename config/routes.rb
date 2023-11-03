# frozen_string_literal: true

Rails.application.routes.draw do
  # Root route
  root 'users#home'

  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks',
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  devise_scope :user do
    get 'logout', to: 'devise/sessions#destroy'
  end
  # Admin dashboard route
  get 'admin_dashboard', to: 'users#admin_dashboard', as: 'admin_dashboard'
  get 'user_dashboard', to: 'users#user_dashboard', as: 'user_dashboard'
  get 'admin_checkin', to: 'users#admin_checkin', as: 'admin_checkin'
  get 'user_checkin', to: 'users#user_checkin', as: 'user_checkin'
  post 'admin_checkin', to: 'users#admin_checkin'
  post 'user_checkin', to: 'users#checkin'
  post 'add_admin', to: 'users#add_admin', as: 'admin_add_admin'
  get '/users/home', to: 'users#home', as: 'users_home'
  get '/events/index', to: 'events#index', as: 'events_index'
  get '/events/new', to: 'events#new', as: 'events_new'

  get 'profile_setup', to: 'users#profile_setup'
  post 'create_profile', to: 'users#create_profile'

  get 'users/events_attended', to: 'users#events_attended', as: 'events_attended'
  get 'users/upcoming_events', to: 'users#upcoming_events', as: 'upcoming_events'

  # Users routes
  resources :users, except: :show do
    collection do
      put :grant_admin
      get 'profile_setup'
      post 'create_profile'
    end

    member do
      post 'checkin'
    end
    post 'add_admin', on: :collection
  end


  # Events routes
  resources :events, only: %i[index new create destroy]

  # Routes for Final Countdown Event
  get 'events/new_final_countdown', to: 'events#new_final_countdown', as: 'new_final_countdown_event'
  post 'events/create_final_countdown', to: 'events#create_final_countdown', as: 'create_final_countdown_event'
  resources :events, only: %i[index show new create destroy]
end
