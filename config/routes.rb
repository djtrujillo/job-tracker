Rails.application.routes.draw do

  root to: 'dashboards#show'

  get '/dashboard', to: 'dashboards#show'

  resources :companies do
    resources :jobs
    resources :contacts, only: [:new, :create]
  end

  resources :jobs, only: [:index] do
    resources :comments, only: [:new, :index, :create]
  end

  resources :categories

end
