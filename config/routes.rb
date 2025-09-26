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
    get "accounts/index"
    get "accounts/new"
    post "accounts/add_credit"
    get "accounts/debit_index"
    post "accounts/add_debit"

    get "reports/index"
    get "reports/report_filter"

    get "payments/index"
    post "payments/approved"
    get "payments/verify_pin"

    get "sessions/login"
    post "sessions/create"
    delete "sessions/destroy"
    get "dashboards/index"
    get "scheme/index"

    # get "user_services/index"
    # get "user_services/new"
    get "user_services/view_blance"
    get "user_services/set_pin"
    post "user_services/set_pin_update"

    resources :user_services

    get "collect_moneys/index"
    get "collect_moneys/new"
    post "collect_moneys/create"


    get "recharges_and_bills/index"
    get "recharges_and_bills/transaction"
    post "recharges_and_bills/amdmin_commission_set"


    post "user_services/create", to: "user_services#create", as: :user_services_create
    # resources :user_services
  end

  namespace :api do
    namespace :v1 do
      namespace :customer do
        post "kycs/user_details"
        post "kycs/aadhaar_otp", to: "kycs#aadhaar_otp"
        post "kycs/verify_aadhaar_otp", to: "kycs#verify_aadhaar_otp"
        post "kycs/manual_aadhaar_upload", to: "kycs#manual_aadhaar_upload"
        post "kycs/pencard_otp", to: "kycs#pencard_otp"
        post "kycs/verify_pencard_otp", to: "kycs#verify_pencard_otp"
        post "kycs/selfie", to: "kycs#selfie"
        get "kycs/kyc_details", to: "kycs#kyc_details"
        post "kycs/submit_kyc_details", to: "kycs#submit_kyc_details"

        get "locations/index"

        post "sessions/login"
        post "sessions/verify_otp"
      end

      namespace :master do
        get "dashboards/index"
      end

      namespace :agent do
        get "dashboards/index"
        post "sessions/login"
        post "sessions/create"
        get "sessions/role"
        post "enquires/create"

        get "user_services/index"
        post "user_services/service_category"
        post "user_services/service_product"
        get "user_services/earn_commission"
        post "user_services/transaction_list"

        post "recharges/recharge"
        post "recharges/recharge_list"
        post "recharges/verify_pin"

        get "wallets/balance"
        post "wallets/create"

        post "filters/category_filter"
        post "filters/service_category_filter"
        post "filters/service_product"

        resources :reatailer_profiles, only: [:index]
        post "reatailer_profiles/set_pin"
      end

    end
  end


  root "superadmin/dashboards#index"

  namespace :superadmin do
    get "customer/index"
    post "customer/verify_status"

    get "reports/index"

    get "commissions/index"
    post "commissions/commission_set"

    get "accounts/index"
    get "accounts/new"
    post "accounts/add_credit"
    get "accounts/debit_index"
    post "accounts/add_debit"

    post "payments/approved"
    get "payments/index"
    get "payments/set_pin"
    post "payments/set_pin_update"

    get "blance/index"
    get "categories/index"
    get "recharge_and_bill/index"
    get "recharge_and_bill/transaction"
    get "recharge_and_bill/view"
    post "recharge_and_bill/commission_set"


    get "service/index"
    get "enqueries/index"


    get "scheme/index"
    post "scheme/create", to: "scheme#create", as: :scheme_create
    post "scheme/update", to: "scheme#update", as: :scheme_update

    resources :scheme, only: [:destroy]

    post "admins/create", to: "admins#create", as: :admins_create
    post "admins/:id/admin_update_stauts", to: "admins#admin_update_stauts", as: :admin_update_status

    resources :admins
    resources :banks
    resources :services
    resources :categories
    resources :service_products do
      member do
        get :view_product_item
      end
    end


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
