Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'job#index'
  post '/job/webhook', to: 'job#webhook'
  get '/job/testaction', to: 'job#testaction'
end
