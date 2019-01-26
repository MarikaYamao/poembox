Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'toppages#index'
  
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  get 'signup', to: 'users#new'
  resources :users, only: [:show, :new, :create, :edit, :update]
  
  resources :photos, only: [:create, :destroy, :show, :new]
  resources :poems, only: [:create, :destroy, :show, :new, :edit, :update]
  resources :likes, only: [:create, :destroy, :show]
  
  resources :follows, controller: :likes, type: 'Follow', only:[:create, :destroy]
  resources :likePhotos, controller: :likes, type: 'LikePhoto', only:[:create, :destroy]
  resources :likePoems, controller: :likes, type: 'LikePoem', only:[:create, :destroy]
end
