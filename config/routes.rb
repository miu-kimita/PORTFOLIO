Rails.application.routes.draw do
 devise_for :admins, skip: :all
 devise_scope :admin do
  get 'admins/sign_in' => 'admins/sessions#new', as: :new_admin_session
  post 'admins/sign_in' => 'admins/sessions#create', as: :admin_session
  delete 'logout' => 'admins/sessions#destroy', as: :destroy_admin_session
end

  namespace :admin do
      root 'homes#index'
      resources :posts,only: [:index,:new,:create,:show,:edit,:update]
      resources :genres,only: [:index,:create,:edit,:update]
      resources :post_users,only: [:index,:show,:edit,:update]
  end

  devise_for :post_users, controllers: {
  sessions:      'post_users/sessions',
  passwords:     'post_users/passwords',
  registrations: 'post_users/registrations'
}

  scope module: 'public' do
    root to: 'homes#top'
    get '/about', to: 'homes#about'
    get 'post_user/my_page', to: 'post_users#show'
    get 'post_users/unsubscribe', to: 'post_users#unsubscribe'
    patch 'post_users/withdrawal', to: 'post_users#withdrawal', as: 'withdrawal'
    resources :post_comments, only: [:edit, :update]

    get '/posts/complete', to: 'posts#complete', as: 'complete'
    resources :posts, only: [:new, :edit, :create, :index, :show]
    post '/posts/confirm', to: 'posts#confirm', as: 'confirm'
    resources :post_users, only: [:index, :show, :edit, :update]
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # namespace :admin do
  #   resources :posts, only: [:new, :create, :edit, :update]
  #   resources :post_users, only: [:index, :show, :edit, :update]
  # end
end