Rails.application.routes.draw do

  root 'prayers#index'
  get '/prayers' => 'prayers#intro';
  get '/prayers/gospel' => 'prayers#gospel';
  get '/prayers/overview' => 'prayers#overview';

  get '/sessions/new' => 'sessions#index';
  post '/sessions' => 'sessions#create';
  delete '/sessions' => 'sessions#destroy';
  
  get '/requests/:id/comments' => 'requests#comments';

  get '/requests' => 'requests#index';
  get '/requests/all/:page' => 'requests#index';
  get '/requests/:filter/' => 'requests#index';
  post '/requests/:filter/' => 'requests#index'
  get '/requests/:filter/:page' => 'requests#index';
 
  
  get '/praises' => 'requests#praises';
  get '/praises/all/:page' => 'requests#praises';
  get '/praises/:filter/' => 'requests#praises';
  get '/praises/:filter/:page' => 'requests#praises';
  
  post '/requests' => 'requests#create';
  patch '/requests/:id/update' => 'requests#update';
  post '/requests/:id/praise' => 'requests#praise';
  post '/requests/:id/comment' => 'requests#comment';
  delete '/requests/:id' => "requests#destroy";
  post '/requests/:id/pray' => 'requests#pray';
  post '/requests/:id/like' => 'requests#like';
  delete '/requests/:id/unlike' => "requests#unlike";

  post '/requests/:id/subscribe' => 'subscriptions#create'
  patch '/subscriptions/:id/decr' => 'subscriptions#decr'
  patch '/subscriptions/:id/incr' => 'subscriptions#incr'
  patch '/subscriptions/:id/renew' => 'subscriptions#renew'
  delete '/subscriptions/:id' => 'subscriptions#destroy'

  get '/users/new' => 'users#new';
  get '/users/password' => 'users#password';
  post '/users/password/change' => 'users#passchange';
  get '/users/:id/edit' => 'users#edit';
  get '/users/:id/:tab' => 'users#show';
  get '/users/:id' => 'users#show';
  patch '/users/:id' => 'users#update';
  post '/users/' => 'users#create';
  delete '/users/:id' => 'users#destroy';

  get '/password/email' => 'password#email';
  post '/password/email' => 'password#emailreset';
  get '/password/:reset_token' => 'password#new';
  post '/password/reset/:reset_token' => 'password#reset';
  # get '/users/password/:reset_token' => 'users#passreset'
  
  get '/test' => 'prayers#orderedlist'
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  

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
