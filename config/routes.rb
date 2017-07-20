Rails.application.routes.draw do

  devise_for :users,
  controllers: { omniauth_callbacks: 'users/omniauth_callbacks'}
  # :controllers => { :omniauth_callbacks => "callbacks" }
  # devise_scope :user do






  get '/index', to: 'scraper#index'
  root to: "pages#home"




  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html


end


