Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  resources :appointments, except: [:destroy]
  devise_for :users

  devise_scope :user do
    authenticated :user do
      root to: 'home#index'
    end
    
    unauthenticated do
      root to: 'devise/sessions#new'
    end
  end

  devise_scope :admin_user do
    authenticated :admin_user do
      root to: 'admin/dashboard#index'
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
