Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  resources :charges, only: [:new, :create]
  devise_for :users
  get '/', :to => 'charges#new'
end