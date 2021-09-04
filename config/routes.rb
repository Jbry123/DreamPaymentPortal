Rails.application.routes.draw do
  get 'welcome/index'
  resources :charges
  get '/', :to => 'welcome#index'
  post '/save_amount', to: 'charges#save_amount', as: 'save_amount'
end