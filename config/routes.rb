Welovemerthyr::Application.routes.draw do
  scope "public" do
    # Homepage.
    get '/front' => 'pages#front'

    # Blog index/post pages.
    get '/blog' => 'pages#blog'
    get '/blog_post/:id' => 'pages#blog_post', as: 'blog_post'

    # Events index/show pages.
    get '/events' => 'pages#events', as: 'public_events'
    get '/event/:id' => 'pages#event', as: 'public_event'

    # Vouchers index/show page.
    get '/vouchers' => 'pages#vouchers', as: 'public_vouchers'
    get '/vouchers/:id' => 'pages#voucher', as: 'public_voucher'

    # Businesses page and business page.
    get '/businesses_category/:cat' => 'pages#businesses_category', as: 'public_businesses_category'
    get '/businesses/search' => 'pages#businesses_results', as: 'public_businesses_search'
    get '/businesses/:id' => 'pages#business', as: 'public_business'

    # Static pages edit by admin.
    get '/templates/:id' => 'pages#static_page', as: 'public_static_page'

    get '/visiting' => 'pages#visiting', as: 'public_visiting'
    get '/guides' => 'pages#guides', as: 'public_guides'

    get '/update_guides_map' => 'pages#update_guides_map', as: 'update_guides_map'

    get 'pages/:id' => 'pages#public_show', as: 'public_page_show'
  end

  scope "admin" do
    resources :pages do
      get 'admin', on: :collection
    end
    resources :page_templates
    resources :posts
    resources :deals, path: 'vouchers'
    resources :sliders
    resources :events
    resources :businesses do
      post '/invite' => 'businesses#invite', on: :member
    end
    resources :business_category_templates
  end

  devise_for :users, controllers: { registrations: 'registrations', sessions: 'sessions', passwords: 'passwords' }

  get '/admin' => redirect('/admin/pages/admin'), as: 'admin'

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root to: 'pages#front'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
