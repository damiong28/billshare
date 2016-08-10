Rails.application.routes.draw do
  
  root 'bills#index', as: 'root_path'
  
  devise_for :accounts
  resources :users
  resources :bills do
    resources :charges
  end
  get 'bills/:id/send', to: 'bills#send_bill', as: :send_bill
  
end