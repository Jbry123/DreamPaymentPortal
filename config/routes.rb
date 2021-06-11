Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users
  resources :charges, only: [:new, :create]
  get '*path' => redirect('/charges/new')
end