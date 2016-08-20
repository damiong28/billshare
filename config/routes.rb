Rails.application.routes.draw do
  
  root 'bills#index', as: 'root_path'
  
  devise_for :accounts, :controllers => {registrations: 'registrations' }
  
  resources :users
  resources :bills do
    resources :charges
  end
  get 'bills/:id/send', to: 'bills#send_bill', as: :send_bill
  get 'settings', to: 'accounts#settings', as: :settings
  get 'reports', to: 'accounts#reports', as: :reports
  
  resources :charts, only: [] do
    collection do
      get 'bill_total_by_month'
      get 'user_charge_chart'
      get 'user_balance_chart'
    end
  end
  
end