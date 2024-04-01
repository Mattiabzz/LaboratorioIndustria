Rails.application.routes.draw do
  get 'pages/index'
  resources :notify_managers
  resources :notify_users
  resources :reservations
  resources :events
  resources :managers
  resources :users
  resources :utentes
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "pages#index"

  post '/user_login', to: 'users#login'
  post '/manager_login', to: 'managers#manager_login'

  get '/user_dashboard', to: 'users#dashboard'
  get '/manager_dashboard', to: 'managers#dashboard'

  post '/login', to: 'pages#login'

end
