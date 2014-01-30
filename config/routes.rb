FoodApp::Application.routes.draw do
 
  root :to => 'main#index'
      
  #match '/users/:id', :to => 'users#show', :as => :user, via: [:get, :post]
  resources :users#, :only => [:update]
  resources :restaurants#, :only => [:update]
  resources :sessions
  resources :timecontrolls#, :only => [:update]
  resources :archyves
  
  #users paths
  get 'changepass' => 'users#change_password'
  patch 'changepass' => 'users#change_password'
  get 'users/food' => 'users#choosefood'
  get 'sign_up' => 'users#new'
  post 'savefood' => 'users#save_food'
  #get 'savefood/:food' => 'users#save_food'
  get 'users' => 'users#index'

  #main paths
  get 'getData' => 'main#getData'
  get 'food' => 'main#choosefood'
  get 'reset/:pass' => 'main#reset'
  
  get 'archyve' => 'main#view_archyves'
  get 'archyve/:id' => 'main#destroy_archyve'
  get 'archyve/u/:id' => 'main#destroy_userarchyve'

  #restaurants paths
  get 'restaurants' => 'restaurants#index'
  get 'vote/:id/:act' => 'restaurants#vote'
  get 'vote/:id' => 'restaurants#vote'
  
  #sessions paths
  get 'log_out' => 'sessions#destroy'
  get 'log_in' => 'sessions#new'
    
  #admin paths
  get 'admin' => 'admin#index'
  post 'start' => 'admin#start'
  patch 'editarchyve' => 'admin#edit_last_archyve'
  
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end
  
  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
