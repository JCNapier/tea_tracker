Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do 
    namespace :v1 do 
      get '/customers/:customer_id/subscriptions', to: 'customer_subscriptions#index'

      post "/subscriptions", to: 'subscriptions#create'
      patch "/subscriptions/:subscription_id", to: 'subscriptions#update'
    end
  end
end
