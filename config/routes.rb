Rails.application.routes.draw do
  devise_for :users
  
  root 'home#index'
  
  # Profile routes
  get 'profile', to: 'profile#edit'
  patch 'profile', to: 'profile#update'
  
  # Spin routes
  get 'spin', to: 'spin#index'
  post 'spin', to: 'spin#create'
  get 'spin/result', to: 'spin#result', as: 'result_spin'

  resources :assignments, only: [] do
    member do
      get :chat, to: 'chats#show'
    end
    resources :messages, only: [:create]
  end
  
  # Health check
  get "up" => "rails/health#show", as: :rails_health_check
end
