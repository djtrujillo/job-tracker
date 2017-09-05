Rails.application.routes.draw do

  resources :companies do
    resources :jobs
    resources :contacts, only: [:new, :create]
  end

  resources :jobs, only: [] do
    resources :comments, only: [:new, :index, :create]
  end

  resources :categories


end
