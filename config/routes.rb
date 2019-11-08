Rails.application.routes.draw do

  get '/(:id)' => 'pages#show', as: 'static'
  root :to => 'pages#home'

end
