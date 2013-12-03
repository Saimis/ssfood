FoodApp::Application.routes.draw do
  resources :timecontrolls

    root :to => 'main#index'
  
  get 'users' => 'users#index'
  
  
  get 'dovote/:id' => 'main#dovote'
  get 'restaurants' => 'restaurants#index'
  get 'users/food' => 'users#choosefood'
  get 'getData' => 'main#getData'
  get 'food' => 'main#choosefood'
  get 'reset/:pass' => 'main#reset'
  post 'savefood' => 'main#savefood'
  #match '/users/:id', :to => 'users#show', :as => :user, via: [:get, :post]
  resources :users
  
  resources :sessions
  
  get 'start' => 'main#start'
  
  get 'log_out' => 'sessions#destroy'
  get 'log_in' => 'sessions#new'
  get 'sign_up' => 'users#new'
  resources :restaurants

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
