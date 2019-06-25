Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  scope '(:locale)', locale: /#{I18n.available_locales.map(&:to_s).join('|')}/ do
    root to: 'toppages#index'
    get 'all', to: 'toppages#index_all'
    
    resources :photos, only: [:create, :destroy, :show, :new]
    resources :poems, only: [:create, :destroy, :show, :new, :edit, :update]
    resources :relationships, only: [:create, :destroy]
    
    get 'login', to: 'sessions#new'
    post 'login', to: 'sessions#create'
    delete 'logout', to: 'sessions#destroy'
    
    get 'signup', to: 'users#new'
    post 'signup', to: 'users#create'
    get '/:id/:user_name' => 'users#show'
    get '/:id/:user_name/edit' => 'users#edit'
    resources :users do
      member do
        get :follow
        get :like
      end
      collection do
        get :search
      end
    end
    
    resources :like_photo, controller: :favorites, type: 'LikePhoto', only: [:create, :destroy]
    resources :like_poem, controller: :favorites, type: 'LikePoem', only: [:create, :destroy]
  end
end
