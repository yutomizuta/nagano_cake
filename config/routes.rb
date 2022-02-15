Rails.application.routes.draw do

  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

  devise_for :end_users, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: "public/sessions"
  }

  namespace :admin do
    root to: "homes#top"
    get "/end_users" => "end_users#index"

    resources :items, only: [:index, :show, :new, :create, :edit, :update]
    resources :genres, only: [:index, :create, :edit, :update]
  end

  scope module: :public do
    root to: 'homes#top'
    get "/publics/mypage" => "end_users#show"
    get "/publics/edit" => "end_users#edit"
    patch "/publics/update" => "end_users#update"
    get "/publics/unsubscribe" => "end_users#unsubscribe"
    patch "/publics/withdraw" => "end_users#withdraw"

    resources :items, only: [:index, :show]
  end
end
