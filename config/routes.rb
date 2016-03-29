Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  root "welcome#home"

  # custom actions for the welcome controller
  get "/home" => "welcome#home"

  resources :sessions, only: [:new, :create] do
    delete :destroy, on: :collection
  end
  resources :password_resets, only: [:new, :create, :edit, :update]
  resources :users do
    get "/change_password" => "users#change_password"
  end
  resources :clients, only: [:new, :create, :index, :destroy]

  resources :categories
  resources :info_requests do
    resources :submissions, only: [:new, :create, :show, :edit, :update, :destroy]
  end
  resources :submissions, only: [:index]
  resources :relationships, only: [:create, :destroy]

  resources :teams
  resources :team_memberships

  resources :client_requests, only: [:index]
  resources :client_submissions, only: [:index]
  resources :consultant_requests, only: [:index]
  resources :consultant_submissions, only: [:index]

  namespace :api, defaults: {format: :json} do
    namespace :v1 do
      resources :info_requests, only: [:index, :show] do
        resources :submissions, only: [] do
          post :update, on: :collection
        end
      end
    end
  end

  resources :conversations, only: [:index, :show, :new, :create] do
    member do
      post :reply
      post :trash
      post :untrash
    end
  end
end
