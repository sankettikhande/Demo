Rails.application.routes.draw do
  devise_for :users, controllers: {sessions: "sessions", passwords: "passwords", registrations: "registrations"}

  devise_scope :user do
    post "registrations/register_guest_user", to: "registrations#register_guest_user", as: :register_guest_user
    #get "/myaccount", to: 'registrations#edit' 
  end

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
   root 'home#landing'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  resources :freights do
    collection do
      post :search
      get :search
      post :import
    end
  end

  resources :home
  resources :bookings do
    resources :rates
    member do
      get :get_quote
      post :add_to_cart
      post :remove_from_cart
      get :remove_from_search
    end
    collection do 
      get :active_bookings
      get :bookings_on_hold
      get :negotiation_round_one
      post :round_one_price_update
      get :seller_confirmation_order
      post :update_booking_status
      get :sellers_confirmed_bookings
      get :draft_bookings
      get :archived_bookings
      get :payment
      get :booking_summary
      get :update_cart_details_section
      get :check_cart_session
      post :filter_with_seller
    end   

  end
  resources :address_books  do
    collection do
      delete :suppliers_consignees_destroy
      get :add_supplier_consignee
      get :check_address_and_redirect
    end
  end

  resources :users do 

  end

  resources :payments do
    collection do
      get :payment_options
      get :processing_payment 
    end
  end

  get '/reviews/:seller_id', to: 'rates#reviews', as: :get_reviews
  get '/reviews_by_stars/:seller_id/:star', to: 'rates#reviews_by_stars'
  get '/myaccount', to: 'users#edit'
  get '/privacy', to: 'users#privacy'
  post '/deleteUserAccount', to: 'users#delete_user_account'
  get '/deleteUserAccount', to: 'users#delete_user_account' 
  get '/register_supplier_consignee', to: 'users#register_supplier_consignee'
  get '/thank_you', to: 'users#thank_you', as: 'thank_you'

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
