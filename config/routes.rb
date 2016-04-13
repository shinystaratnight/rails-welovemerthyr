Welovemerthyr::Application.routes.draw do
  match 'auth/:provider/callback' => 'subscribers#callback_facebook'
  match 'auth/failure' => redirect('/')

  resources :subscribers do
    post '/subsribe' => 'subscribers#subscribe', on: :collection
  end

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

    resources :businesses do
      post '/invite' => 'businesses#invite', on: :member
    end

    resources :deals, path: 'vouchers'
    resources :page_templates
    resources :posts
    resources :sliders
    resources :events
    resources :business_category_templates
    resources :downloads
  end

  devise_for :users, controllers: { registrations: 'registrations', sessions: 'sessions', passwords: 'passwords' }

  get '/admin' => redirect('/admin/pages/admin'), as: 'admin'

  root to: 'pages#front'

  api vendor_string: "welovemerthyr", default_version: 1 do
    version 1 do
      cache as: 'v1' do
        match :posts, to: 'posts#index', via: [:options]
        resources :posts, only:  %w(index show)

        match :events, to: 'events#index', via: [:options]
        match 'events/:id', to: 'events#show', via: [:options]
        resources :events, only:  %w(index show)

        match :deals, to: 'deals#index', via: [:options]
        match 'deals/:id', to: 'deals#show', via: [:options]
        resources :deals, only:  %w(index show)

        match :businesses, to: 'businesses#index', via: [:options]
        match 'businesses/:id', to: 'businesses#show', via: [:options]
        resources :businesses, only:  %w(index show)

        match :business_categories, to: 'businesses#index', via: [:options]
        get 'business_categories', to: "businesses#index" 

        match 'business_categories/:category', to: 'businesses#index', via: [:options]
        get 'business_categories/:category', to: "businesses#index" 

        match 'deleted_records', to: 'deleted_records#index', via: [:options]
        resources :deleted_records, only:  %w(index)
      end
    end

  end

  #redirects
  match '/facebook' => redirect('http://www.facebook.com/welovemerthyr')
  match '/twitter' => redirect('http://www.twitter.com/welovemerthyr')
  match '/xmas2014_fb' => redirect('https://www.facebook.com/events/1468240193457417')
end
