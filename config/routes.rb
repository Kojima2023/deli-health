Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  get 'tops/index' => 'tops#index'
  get 'tomorecipes/sick' => 'tomorecipes#sick'
  get 'tomorecipes/allergy' => 'tomorecipes#allergy'
  get 'tomorecipes/weak' => 'tomorecipes#weak'
  get 'tomorecipes/others' => 'tomorecipes#others'

  # マイページのルーティング
  get 'users/:id/profile', to: 'users#show', as: 'user_profile'
  get 'users/:id/show_good' => 'users#show_good', as: 'show_good_user'

  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  
  resources :users, only: [:show]
  
  resources :tomorecipes do
    resources :likes, only: [:create, :destroy]
  end

  resources :tags do
    get 'tomorecipes', to: 'tomorecipes#search'
  end
  
  root 'tops#index'
end
