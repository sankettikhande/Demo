Rails.application.routes.draw do
  devise_for :users, controllers: {sessions: "sessions", registrations: "registrations"}

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
    member do
      get :get_quote
    end
    collection do 
      get :active_bookings
      get :bookings_on_hold
      get :draft_bookings
      get :archived_bookings
      get :payment
    end   
  end
  resources :address_books 

  resources :users do 

  end

  get '/myaccount', to: 'users#edit'
  get '/privacy', to: 'users#privacy'
  post '/deleteUserAccount', to: 'users#delete_user_account'
  get '/deleteUserAccount', to: 'users#delete_user_account' 
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
