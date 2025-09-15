Rails.application.routes.draw do
  # root を pages#home に変更
  root "pages#home"
  
  get "home/index"
  get "up" => "rails/health#show", as: :rails_health_check
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
end
