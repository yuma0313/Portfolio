Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  root to: 'homes#top'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :post_images do
    resource :favorites, only: [:index,:create, :destroy,]
    resource :bookmarks, only: [:index,:create, :destroy,]
    collection do
      get "search"
    end
  end
  resources :events
  resources :users do
    collection do
      get :favorites
      get :bookmarks
    end
  end
  get 'users/:id/unsubscribe' => 'users#unsubscribe', as: 'confirm_unsubscribe'
  patch 'users/:id/withdraw' => 'users#withdraw', as: 'withdraw_user'
  put 'users/:id/withdraw' => 'users#withdraw'
  get "/about" => "homes#about" ,as: "about"
  # get '/search', to: 'search#search'
end
