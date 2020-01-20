Rails.application.routes.draw do

  root 'home#top'

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  devise_scope :user do
    get 'addresses', to: 'users/registrations#new_address'
    post 'addresses', to: 'users/registrations#create_address'
    get "signup/registration" => "users/registrations#new"
    post "signup/registration" => "users/registrations#create"
    get "/login" => "users/sessions#new"
    get "users/sign_out" => "users/sessions#destroy"
  end
  resources :users, only: [:edit, :update]
  resources :items, only: [:show, :new, :create, :edit, :update]
  get "/mypage" => "users#mypage"
  get "/mypage/profile" => "users#profile"
  post "/mypage/profile" => "users#profile_update"
  get "/logout" => "users#logout"
  get "/buy/:id" => "items#buy", as: :buy
  post "/stop/:id" => "items#stop", as: :stop
  post "/start/:id" => "items#start", as: :start
end
