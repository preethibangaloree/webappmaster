Rails.application.routes.draw do
  get 'data/create'
  get 'data/update'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  resources :data, only: [:create, :update]
end
