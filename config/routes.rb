SpaghettiprogrammingCom::Application.routes.draw do
  resources :sessions, :only => [:new, :create, :destroy]
  resources :users, :only => [ :edit, :update ]
  resources :blog_posts do
    collection do
      resources :unpublished, only: [:index]
    end
    member do
      resources :slugs, only: [:show]
    end
  end

  get '/signin', :to => 'sessions#new'
  get '/signout', :to => 'sessions#destroy'
  #get '/(:id)' => 'pages#show', :as => 'static'
  root :to => 'blog_posts#index'

  unless Rails.env == 'development'
    get '*not_found', :to => 'errors#error_404'
    post '*not_found', :to => 'errors#error_404'
    put '*not_found', :to => 'errors#error_404'
    delete '*not_found', :to => 'errors#error_404'
  end

end
