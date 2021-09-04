Rails.application.routes.draw do
  get 'welcome/index'
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  resources :charges
  devise_for :users
  get '/', :to => 'welcome#index'
  post '/save_amount', to: 'charges#save_amount', as: 'save_amount'
end