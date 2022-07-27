Rails.application.routes.draw do
  resources :nfts, only: %i[index show new create]
  get 'greetings/index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
