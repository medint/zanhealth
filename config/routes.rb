Med8::Application.routes.draw do

  devise_for :users
  resources :parts

  resources :texts
  
  resources :bmet_work_order_comments

  resources :bmet_item_histories

  resources :bmet_needs

  resources :bmet_items

  resources :models

  resources :bmet_work_orders

  resources :roles

  resources :facilities

  resources :departments

  resources :bmet_labor_hours

  resources :facility_work_orders

  resources :facility_work_order_comments

  resources :facility_costs

  resources :facility_labor_hours

  resources :facility_preventative_maintenances

  resources :facility_work_requests

  get "/facility_dashboard/status", to: "facility_dashboard#status"

  get "/facility_dashboard/wo_finances", to: "facility_dashboard#wo_finances"

  resources :facility_dashboard

  get "/my_bmet_work_orders", to: "bmet_work_orders#my"

  get "/detailed_bmet_work_orders", to: "bmet_work_orders#detailed"

  get "/detailed_items", to: "bmet_items#detailed"
  
  get "/text", to: "text#receive"

  get "/facility_work_requests/:num/new", to: "facility_work_requests#new_shortcut"  

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
