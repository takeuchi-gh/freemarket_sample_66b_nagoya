Rails.application.routes.draw do

  root 'home#add_item'

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  devise_scope :user do
    get "signup/registration" => "users/registrations#new"
    post "signup/registration" => "users/registrations#create"
    post "users/sign_up" => "users/registrations#create"
    get "users/sign_out" => "users/sessions#destroy"
  end
  resources :users, only: [:edit, :update]
  get "/mypage" => "users#mypage"
  get "/mypage/profile" => "users#profile"
  post "/mypage/profile" => "users#profile_update"
  get "/logout" => "users#logout"
end
