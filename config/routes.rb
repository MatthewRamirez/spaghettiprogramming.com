SpaghettiprogrammingCom::Application.routes.draw do
  resources :sessions, :only => [:new, :create, :destroy]
  resources :users, :only => [ :edit, :update ]
  resources :blog_posts do
    collection do
      get '/archive/:id' => 'blog_posts#archive', :as => 'archive'
      get '/unpublished' => 'blog_posts#unpublished_index', :as => 'unpublished'
    end
  end
  get '/blog_posts/slug/:slug' => 'blog_posts#slug', :as => 'blog_slug'

  resources :categories do
    resources :blog_posts, :only => [ :index ]
  end

  get '/home', :to => 'pages#home'
  get '/', :to => 'pages#home'
  get '/signin', :to => 'sessions#new'
  get '/signout', :to => 'sessions#destroy'
  root :to => 'blog_posts#index'

  unless Rails.env == 'development'
    get '*not_found', :to => 'errors#error_404'
    post '*not_found', :to => 'errors#error_404'
    put '*not_found', :to => 'errors#error_404'
    delete '*not_found', :to => 'errors#error_404'
  end

end
