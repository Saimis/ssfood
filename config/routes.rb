FoodApp::Application.routes.draw do
  root to: 'main#index'

  namespace :admin do
    get '/' => 'dashboard#index', as: :dashboard
    get 'session_start' => 'dashboard#session_start', as: :start_session
    resources :restaurants
    resources :users
    resources :orders
    resources :order_users, only: [:destroy]
  end

  resources :users
  resources :restaurants
  resources :sessions

  # Users paths
  get 'changepass' => 'users#change_password'
  patch 'changepass' => 'users#change_password'
  get 'users/food' => 'users#choosefood'
  get 'sign_up' => 'users#new'
  post 'savefood' => 'users#save_food'
  get 'users' => 'users#index'

  # Main paths
  get 'get_data' => 'main#get_data'
  get 'callerpopup' => 'main#create_popup'
  get 'food' => 'main#choosefood'
  get 'reset/:pass' => 'main#reset'
  post 'force_round_end' => 'main#end_round'

  # Restaurants paths
  get 'restaurants' => 'restaurants#index'
  get 'vote/:id/:act' => 'restaurants#vote'
  get 'vote/:id' => 'restaurants#vote'

  # Sessions paths
  get 'log_out' => 'sessions#destroy'
  get 'log_in' => 'sessions#new'
  get 'start/:a/:b' => 'sessions#autologin'

  # Admin paths
  get 'stats' => 'statistics#index'
  get 'stats/amount' => 'statistics#amount'
end
