Rails.application.routes.draw do
  get 'pages/index'
  resources :notify_managers
  resources :notify_users
  resources :reservations ,only: [:create, :destroy]
  resources :events
  resources :managers
  resources :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "pages#index"

  #post '/user_login', to: 'users#login'
  #post '/manager_login', to: 'managers#manager_login'

  get '/user_dashboard', to: 'users#dashboard'
  get '/manager_dashboard', to: 'managers#dashboard'

  post '/login', to: 'pages#login'

  delete '/logout_manager', to: 'pages#logout_manager'
  delete '/logout_user', to: 'pages#logout_user'

  get '/ricerca_eventi', to: 'events#ricerca_eventi'


  get '/ispeziona_eventi', to: 'events#ispeziona_eventi'

  get '/notifiche_utenti', to: 'notify_users#notifiche_utenti'

  get '/notifiche_manager', to: 'notify_managers#notifiche_manager'

  #post 'prenota_evento' to: 'reservation#prenota_evento'

end
