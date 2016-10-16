Rails.application.routes.draw do

  post "/children/index" => "center#index"
  post "/parents/index" => "center#index"
  post "/teachers/index"  => "center#index"
  post "/groups/index"  => "center#index"
  post "/locations/index"  => "center#index"

  post "/children/new" => "center#index"
  post "/parents/new" => "center#index"
  post "/teachers/new" => "center#index"
  post "/groups/new" => "center#index"
  post "/locations/new" => "center#index"

  delete "/families/destroy" => "family#show"
  delete "/group_teachers/destroy" => "group_teacher#show"


  get "/centers/admin", as: :admin

  get "/centers/index", as: :superadmin

  get 'info_pages/home', as: :home

  get 'info_pages/help', as: :help

  get "/parent-log-in" => "sessions#new_parent", as: :parent_log_in

  post "/parent-log-in" => "sessions#create_parent"

  delete "/parent-log-out" => "sessions#destroy_parent", as: :parent_log_out

  get "/teacher-log-in" => "sessions#new_teacher", as: :teacher_log_in

  post "/teacher-log-in" => "sessions#create_teacher"

  delete "/teacher-log-out" => "sessions#destroy_teacher", as: :teacher_log_out

  get "/center-log-in" => "sessions#new_center", as: :center_log_in

  post "/center-log-in" => "sessions#create_center"

  delete "/center-log-out" => "sessions#destroy_center", as: :center_log_out

  get "/superadmin" => "sessions#new_center"

  root 'info_pages#home'

  resources :handoffs
  resources :centers
  resources :parents
  resources :children
  resources :families
  resources :groups
  resources :teachers
  resources :group_teachers
  resources :locations
  resources :centers_password_resets, only: [:new, :create, :edit, :update]
  resources :teachers_password_resets, only: [:new, :create, :edit, :update]


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
