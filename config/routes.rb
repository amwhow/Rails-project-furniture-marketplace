Rails.application.routes.draw do
  resources :listings do 
    resources :savelistings
  end
  get '/dashboard', to:'admins#index', as: 'dashboard'
  delete '/dashboard', to:'admins#destroy'

  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'home#index'
end
