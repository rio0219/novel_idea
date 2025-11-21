Rails.application.routes.draw do
  get "likes/create"
  get "likes/destroy"
  get "ai_consultations/index"
  get "ai_consultations/create"
  devise_for :users, controllers: {
    registrations: "users/registrations",
    omniauth_callbacks: "users/omniauth_callbacks"
  }
  root "home#index"

  get "home/index"
  get "up" => "rails/health#show", as: :rails_health_check
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  get "/terms", to: "pages#terms"
  get "/privacy", to: "pages#privacy"

  resources :ai_consultations, only: [ :index, :create ]
  resources :users, only: [ :show, :edit, :update ]

  resources :works do
    resources :characters, except: :show
    resource :worldview, only: [ :new, :create, :edit, :update, :destroy ]
    resources :plots
  end

  resources :posts do
    resources :comments, only: [ :create, :destroy ]
    resources :likes, only: [ :create, :destroy ]
    collection do
      get :search
      get :autocomplete
    end
  end

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end
