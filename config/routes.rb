Rails.application.routes.draw do

  resources :companies do
    resources :jobs
  end

  resources :categories, only: [:new, :show, :create]

end
