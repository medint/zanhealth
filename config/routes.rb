Zanhealth::Application.routes.draw do

  # general
  resources :departments
  resources :facilities
  devise_for :users
  resources :parts
  resources :roles
  resources :texts
  
  #bmet app
  resources :bmet_items
  resources :bmet_item_histories
  resources :bmet_labor_hours
  resources :bmet_models
  resources :bmet_needs
  resources :bmet_preventative_maintenances
  resources :bmet_work_orders
  resources :bmet_work_order_comments
  resources :bmet_work_requests
  resources :bmet_costs
  resources :part_transactions
  
  #facilities app
  resources :facility_work_orders, except: :show do
  	  collection { get :search }
  end
  resources :facility_work_order_comments
  resources :facility_costs
  resources :facility_labor_hours
  resources :facility_preventative_maintenances, except: :show do
    collection { get :search }
  end
  resources :facility_work_requests, except: :show  do
    collection { get :search }
  end
  
  # export to csv feature
  get "/facility_preventative_maintenances/download", to: "facility_preventative_maintenances#as_csv"
  get "/facility_work_orders/download", to: "facility_work_orders#as_csv"
  get "/facility_work_requests/download", to: "facility_work_requests#as_csv"

  #dashboard
  
  get "/facility_dashboard/status", to: "facility_dashboard#status"
  get "/facility_dashboard/wo_finances", to: "facility_dashboard#wo_finances"
  get "/facility_dashboard/labor_hours", to: "facility_dashboard#labor_hours"
  get "/facility_dashboard/statusAjax", to: "facility_dashboard#statusAjax"
  resources :facility_dashboard

  # hide/unhide features for facility work orders
  put "hide_facility_work_order/:id", to:"facility_work_orders#hide", :as => :hide_facility_work_order
  get "/facility_work_orders/unhidden", to: "facility_work_orders#index"
  get "/facility_work_orders/unhidden/:id", to: "facility_work_orders#show"
  get "/facility_work_orders/hidden/", to: "facility_work_orders#hidden"
  get "/facility_work_orders/hidden/:id", to: "facility_work_orders#show_hidden"
  get "/facility_work_orders/all/", to: "facility_work_orders#all"
  get "/facility_work_orders/all/:id", to: "facility_work_orders#show_all"
  get "/facility_work_orders/:id", to: "facility_work_orders#show_all"

  # hide/unhide features for facility preventative maintenances
  put "hide_facility_preventative_maintenance/:id", to: "facility_preventative_maintenances#hide", :as => :hide_facility_preventative_maintenance
  get "/facility_preventative_maintenances/unhidden", to: "facility_preventative_maintenances#index"
  get "/facility_preventative_maintenances/unhidden/:id", to: "facility_preventative_maintenances#show"
  get "/facility_preventative_maintenances/hidden", to: "facility_preventative_maintenances#hidden"
  get "/facility_preventative_maintenances/hidden/:id", to: "facility_preventative_maintenances#show_hidden"
  get "/facility_preventative_maintenances/all", to: "facility_preventative_maintenances#all"
  get "/facility_preventative_maintenances/all/:id", to: "facility_preventative_maintenances#show_all"

  # hide/unhide features for facility work requests
  put "hide_facility_work_request/:id", to: "facility_work_requests#hide", :as => :hide_facility_work_request
  get "/facility_work_requests/unhidden", to: "facility_work_requests#index"
  get "/facility_work_requests/unhidden/:id", to: "facility_work_requests#show"
  get "/facility_work_requests/hidden", to: "facility_work_requests#hidden"
  get "/facility_work_requests/hidden/:id", to: "facility_work_requests#show_hidden"
  get "/facility_work_requests/all", to: "facility_work_requests#all"
  get "/facility_work_requests/all/:id", to: "facility_work_requests#show_all"

  # hide/unhide features for bmet work orders
  put "hide_bmet_work_order/:id", to: "bmet_work_orders#hide", :as => :hide_bmet_work_order

  get "/facility_work_requests/:facility_id/public_new", to: "facility_work_requests#public_new"  
  post "/facility_work_requests/public_create", to: "facility_work_requests#public_create"  
  get "/facility_work_requests/public_show/:id", to: "facility_work_requests#public_show"  

  get "/bmet_work_requests/:facility_id/public_new", to: "bmet_work_requests#public_new"  
  post "/bmet_work_requests/public_create", to: "bmet_work_requests#public_create"  
  get "/bmet_work_requests/public_show/:id", to: "bmet_work_requests#public_show"  

  get "/my_bmet_work_orders", to: "bmet_work_orders#my"
  get "/detailed_bmet_work_orders", to: "bmet_work_orders#detailed"
  get "/detailed_items", to: "bmet_items#detailed"
  get "/text", to: "text#receive"
    
  get '/404', :to => redirect('/404.html')
  root to: "facility_work_orders#index"



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
