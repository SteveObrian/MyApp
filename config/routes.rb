Rails.application.routes.draw do
  devise_for :users
  root to: 'accounts#index'
  resources :accounts do
    resources :transactions, only: [:create, :new]
  end

  namespace :api do
    namespace :v1 do
      post 'accounts/new_transaction', to: 'accounts#new_transaction'
    end
  end
end
