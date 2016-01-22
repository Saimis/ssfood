FoodApp::Application.routes.draw do
  root to: 'main#index'

  namespace :admin do
    get '/' => 'dashboard#index', as: :dashboard
    get 'session_start' => 'dashboard#session_start', as: :start_session

    resources :restaurants
    resources :users
    resources :orders do
      get 'page/:page', action: :index, on: :collection
    end
    resources :order_users, only: [:destroy]
    resources :amounts, only: [:index, :show, :update]
  end

  resources :statistics, only: [:index]
  resources :sessions
  resources :users, only: [:update]

  # Users paths
  get 'changepass' => 'users#change_password'
  patch 'changepass' => 'users#change_password'
  post 'savefood' => 'users#save_food'

  # Main paths
  get 'get_data' => 'main#get_data'
  get 'callerpopup' => 'main#create_popup'
  get 'reset/:pass' => 'main#reset'
  post 'force_round_end' => 'main#end_round'

  # Restaurants paths
  get 'vote/:id/:act' => 'restaurants#vote'
  get 'vote/:id' => 'restaurants#vote'

  # Sessions paths
  get 'log_out' => 'sessions#destroy'
  get 'log_in' => 'sessions#new'
  get 'start/:a/:b' => 'sessions#autologin'
end
