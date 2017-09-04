Rails.application.routes.draw do

  resources :companies do
    resources :jobs 
  end

  resources :jobs, only: [] do
    resources :comments, only: [:new, :index, :create]
  end

  resources :categories


end
