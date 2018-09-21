Rails.application.routes.draw do
  get 'help', to:'static_pages#help'
  get 'about', to:'static_pages#about'
  get 'login', to:'sessions#new'
  post 'login', to:'sessions#create'
  delete 'logout', to:'sessions#destroy'
  resources :users
  resources :personal_schedules, only:[:create, :edit, :update, :destroy]
  root 'static_pages#home'
end
