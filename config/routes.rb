FunImages::Application.routes.draw do
  match '/i/uploads/*path' => "gridfs_controller#serve"

  namespace :admin do
    root :to => 'welcome#index'
    resources :images do 
      resources :comments, :only => [:destroy, :edit]
    end
    resources :users, :only => :index
  end

  resources :images, :only => [] do
    resources :comments, :only => [:new, :create] do
      get 'i_like'
      get 'dont_like'
    end
  end

  namespace :my do
    resources :comments, :only => [:index] 
  end
  match 'comments/i_like' => 'my/comments#i_like'

  # js
  match 'javascripts/js_translations' => 'js_translations#index'

  root :to => "welcome#index"

  match '/:shown_date' => 'welcome#index_with_date', :constraints => {:shown_date => /\d{4}-\d{2}-\d{2}/}

  devise_for :users, :controllers => {:omniauth_callbacks => 'authentications'} do
    root :to => 'welcome#index'
  end

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

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
