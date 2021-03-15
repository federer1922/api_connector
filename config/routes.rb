Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root to: "home#home"

  get '/contacts', to: 'contacts#index'

  post '/contacts', to: 'contacts#create'

  delete '/contacts', to: 'contacts#delete'

  get '/contacts', to: 'contacts#show'
end
