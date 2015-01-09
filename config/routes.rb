Rails.application.routes.draw do
  get 'cv/index'

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

  
  #  match '/dashboard.json' => 'file#create', via: :post

  match '/dashboard.json' => 'file#create', via: :post
  match '/todo.json' => 'file#todo', via: :post
  match '/cv/personalia.json' => 'cv#personalia', via: :post
  match '/cv/talen.json' => 'cv#talen', via: :post
  match '/cv/opleidingen.json' => 'cv#opleidingen', via: :post
  match '/cv/werkervaring.json' => 'cv#werkervaring', via: :post


  

  get '/:locale' => 'shas#index'

  scope "/:locale" do
    root 'shas#index'
    resources :shas
    match '/storagedb', to: 'shas#storage', via: 'get'
    match '/public_download', to: 'shas#public', via: 'get'
    match '/storagedb', to: 'shas#storage', via: 'get'
    match '/help', to: 'shas#help', via: 'get'
    match '/settings', to: 'shas#settings', via: 'get'
    match '/status', to: 'shas#status', via: 'get'
    match '/change', to: 'shas#change', via: 'get'
    match '/test', to: 'shas#test', via: 'get'
  end



  #resources :shas



  #get '*path' => redirect('/')

end
