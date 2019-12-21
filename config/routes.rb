Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :articles
  root 'welcome#home'
  get '/about' => 'welcome#about'
  get '/signup' => 'users#new',as:'signup'
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  delete '/logout' => 'sessions#destroy'
  resources :users,expect: [:new]  

end
