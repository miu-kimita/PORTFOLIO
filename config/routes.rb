Rails.application.routes.draw do
  scope '(:locale)', locale: /#{I18n.available_locales.map(&:to_s).join('|')}/ do
    # For details on the DSL available within this file, see
    #resources :resource_As 元記事には存在したがこれを記入するとエラーが発生するのでコメントアウト
  end
  devise_for :admins, skip: :all
  #devise_scope :admin do
    # get 'admins/sign_in' => 'admins/sessions#new', as: :new_admin_session
    # post 'admins/sign_in' => 'admins/sessions#create', as: :admin_session
    # delete 'logout' => 'admins/sessions#destroy', as: :destroy_admin_session
  #end
  #(本来は不要である記述だが、細かい修正を行っている中で必要になる場合もあった物の為、コメントアウトに。)

  devise_for :admins, controllers: {
    #sessions:      'admins/sessions',
    #passwords:     'admins/passwords',（無くても良いが念のためコメントアウト）
    registrations: 'admins/registrations'
  }

  namespace :admin do
    root 'homes#top'
    resources :posts,only: [:index,:show]
    resources :genres,only: [:index,:create,:edit,:update]
    resources :post_users,only: [:index,:show,:edit,:update]
  end

  devise_for :post_users, controllers: {
    omniauth_callbacks: 'post_users/omniauth_callbacks',
    sessions:      'post_users/sessions',
    passwords:     'post_users/passwords',
    registrations: 'post_users/registrations'
  }

  scope module: 'public' do
    root 'homes#top'
    get '/search' => 'search#search'
    get '/about', to: 'homes#about'
    get 'post_users/my_page', to: 'post_users#show'
    get 'post_users/unsubscribe', to: 'post_users#unsubscribe'
    patch 'post_users/withdrawal', to: 'post_users#withdrawal', as: 'withdrawal'

    get '/posts/complete', to: 'posts#complete', as: 'complete'

    resources :post_users, only: [:index, :show, :edit, :update]

    resources :posts, only: [:new, :edit, :create, :index, :show, :destroy] do
      resources :post_comments, only: [:create, :destroy]
      resource :favorites, only: [:create, :destroy]
      resource :bookmarks, only: [:create, :destroy]
    end

    resources :contacts, only: [:new, :create]
    post 'contacts/confirm', to: 'contacts#confirm', as: 'confirm'
    post 'contacts/back', to: 'contacts#back', as: 'back'
    get 'done', to: 'contacts#done', as: 'done'

  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # namespace :admin do
  #   resources :posts, only: [:new, :create, :edit, :update]
  #   resources :post_users, only: [:index, :show, :edit, :update]
  # end
end