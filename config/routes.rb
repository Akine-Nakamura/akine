Rails.application.routes.draw do
  devise_for :users
  
  get 'users/index', to: 'users#index'
  get 'users/:id', to: 'users#show', as: 'user'
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get 'tweets/new' => 'tweets#new'
  get 'tweets' => 'tweets#index'
  get 'tweets/top' => 'tweets#top'
  get 'tweets/:id' => 'tweets#show'
  patch 'tweets/:id' => 'tweets#update'
  delete 'tweets/:id' => 'tweets#destroy'
  get 'tweets/:id/edit' => 'tweets#edit', as:'edit_tweet'
  get 'rooms' => 'rooms#index'
 
  resources :tweets do
    resources :likes, only: [:create, :destroy]
    resources :comments, only: [:create]
  end
  
  resources :users, :only => [:index, :show]
  resources :messages, :only => [:create]
  resources :rooms, :only => [:create, :show]
  root 'tweets#top'

end
