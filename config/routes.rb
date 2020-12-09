Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :routes
  get '/auto_assign_routes', to: 'routes#auto_assign_routes'
end
