FunImages::Application.routes.draw do
  namespace :admin do
    root :to => 'welcome#index'
    resources :images do 
      resources :comments, :only => [:destroy, :edit]
    end
    resources :users, :only => [:index, :show, :edit, :update]
  end

  resources :images, :only => [] do
    resources :comments, :except => [:index, :show] do
      get 'i_like'
      get 'dont_like'
    end
  end

  namespace :my do
    resources :comments, :only => [:index]
    resources :account, :only => [:index] do
      collection do
        post 'change_nick'
      end
    end
    resources :statistics, :only => :index
  end
  match 'comments/i_like' => 'my/comments#i_like'

  # js
  match 'javascripts/js_translations' => 'js_translations#index'

  root :to => "welcome#index"

  match '/:shown_date' => 'welcome#index_with_date', :constraints => {:shown_date => /\d{4}-\d{2}-\d{2}/}

  devise_for :users, :controllers => {:omniauth_callbacks => 'authentications'} do
    root :to => 'welcome#index'
  end

  match '/:user_name' => 'user_public_page#index'
  match '/:user_name/:shown_date' => 'user_public_page#index_with_date', :constraints => {:shown_date => /\d{4}-\d{2}-\d{2}/}
end
