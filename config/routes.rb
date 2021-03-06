Mm::Application.routes.draw do
  devise_for :users, :controllers => { :registrations => :registrations }
  devise_for :models

  devise_scope :user do
    root :to => 'devise/sessions#new'
    match 'profile/:phone_number' => 'user#index', via: [:put, :get], :as => :profile
    match 'sms/receive_sms' => 'sms#receive_sms'  #kim's messing with stuff
  end
  

  get 'user_messages' => 'user#get_user_messages'
  get 'all_messages' => 'admin#get_user_messages'
  
#resources :emily, :collection => { :subscribe_to => :put }

  get 'andre' => 'andre#index'
  post 'andre' => 'andre#new_something'
  delete 'andre' => 'andre#delete_something'
#post 'andre' => 'andre#new_category', as: :new_category

  get 'admin' => 'admin#index'
  post 'admin' => 'admin#new_something'
  delete 'admin' => 'admin#delete_something'
  get 'admin/download' => 'admin#download'
  post 'admin/create' => 'admin#create_new_admin'

  #match 'profile/:phone_number' => 'user#index', :as => :profile
  #get '/profile/:phone_number', to: 'user#index', as: 'profile'

  #devise_for :users, :controllers => { :registrations => "registrations" }

  #match '/user/index', :controller => 'user', :action => 'index'

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
  #   namespace :user do
  #     # Directs /user/products/* to Admin::ProductsController
  #     # (app/controllers/user/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'

#Test
end
