FoodApp::Application.routes.draw do
  root to: 'main#index'

  resources :users
  resources :restaurants
  resources :sessions
  resources :archyves

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

  # User Archive paths
  get 'archyve/u/:id' => 'main#destroy_userarchyve'

  # Restaurants paths
  get 'restaurants' => 'restaurants#index'
  get 'vote/:id/:act' => 'restaurants#vote'
  get 'vote/:id' => 'restaurants#vote'

  # Sessions paths
  get 'log_out' => 'sessions#destroy'
  get 'log_in' => 'sessions#new'
  get 'start/:a/:b' => 'sessions#autologin'

  # Admin paths
  get 'admin' => 'admin#index'
  get 'admin/archyves' => 'admin#archyves'
  post 'start' => 'admin#start'
  get 'stats' => 'statistics#index'
  get 'stats/amount' => 'statistics#amount'
  get 'stats/amount/:id' => 'statistics#amount'
end
