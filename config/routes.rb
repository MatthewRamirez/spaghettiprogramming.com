SpaghettiprogrammingCom::Application.routes.draw do
  resources :sessions, :only => [:new, :create, :destroy]
  resources :users, :only => [ :new, :create ]
  resources :advertisements, :only => [ :show, :destroy ]
  resources :blog_posts
  get '/unpublished' => 'blog_posts#unpublished_index', :as => 'unpublished_blog_posts'

  resources :categories do
    resources :blog_posts, :only => [ :index ]
  end

  get '/home', :to => 'pages#home'
  get '/', :to => 'pages#home'
  match '/signin', :to => 'sessions#new'
  match '/signout', :to => 'sessions#destroy'
  match '/auth/:provider/callback' => 'sessions#create'
  root :to => 'blog_posts#index'

end
