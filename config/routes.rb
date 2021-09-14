Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  get 'welcome/index'
  resources :charges
  get '/', :to => 'welcome#index'
  post '/save_amount', to: 'charges#save_amount', as: 'save_amount'
  get '/api' => "api/v1/compaigns#index"
end