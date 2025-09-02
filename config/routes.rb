Rails.application.routes.draw do

  namespace :dealer do
    get "sessions/login"
    post "sessions/create"
    delete "sessions/destroy"
    get "dashboards/index"
  end

  namespace :master do
    get "sessions/login"
    post "sessions/create"
    delete "sessions/destroy"
    get "dashboards/index"
    get "users/index"
  end

  namespace :admin do
    get "sessions/login"
    post "sessions/create"
    delete "sessions/destroy"
    get "dashboards/index"
    get "scheme/index"
  end

  namespace :api do
    namespace :v1 do

      namespace :master do
        get "dashboards/index"
      end

      namespace :agent do
        get "dashboards/index"
        post "sessions/login"
        post "sessions/create"
        get "sessions/role"
        post "enquires/create"
        resources :reatailer_profiles, only: [:index]
      end

    end
  end


  root "superadmin/dashboards#index"

  namespace :superadmin do
    get "blance/index"
    get "categories/index"
    get "recharge_and_bill/index"
    get "service/index"
    get "enqueries/index"


    get "scheme/index"
    post "scheme/create", to: "scheme#create", as: :scheme_create
    resources :scheme, only: [:destroy]
    
    post "admins/create", to: "admins#create", as: :admins_create
    post "admins/:id/admin_update_stauts", to: "admins#admin_update_stauts", as: :admin_update_status
    resources :admins

    resources :banks

    namespace :dealer do
      get "dashboards/index"
    end

    namespace :master do
      get "dashboards/index"
    end


    get "dashboards/index"
    resources :retailers
    post "retailers/create", to: "retailers#create", as: :retailer_create
    post "retailers/:id/update_status", to: "retailers#update_status", as: :retailer_update_status
    resources :roles
  end


  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
  # root "posts#index"
end
