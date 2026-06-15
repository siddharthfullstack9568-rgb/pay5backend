Rails.application.routes.draw do
  scope :sessions, controller: :sessions do
    # Login
    get  :login,                action: :login,              as: :login_sessions
    post :create,               action: :create,             as: :create_sessions

    # OTP Verification (for login)
    get  :otp,                  action: :otp,                as: :otp_sessions
    post :verify_otp_login,     action: :verify_otp_login,   as: :verify_otp_login_sessions

    # Forgot Password
    get  :forgot,               action: :forgot,             as: :forgot_sessions
    post :forgot_email,         action: :forgot_email,       as: :forgot_email_sessions

    # OTP Verification (for forgot password)
    get  :opt_page,           action: :opt_page,         as: :opt_page_sessions
    post :verify_otp,           action: :verify_otp,         as: :verify_otp_sessions

    # Set Password (after forgot OTP verified)
    get  :set_password,         action: :set_password,       as: :set_password_sessions
    post :set_password,  action: :set_password, as: :set_password_update_sessions

    # Logout
    delete :logout,             action: :logout,             as: :logout_sessions
  end



  namespace :dealer do
    get "sessions/login"
    post "sessions/create"
    get "sessions/forgot_page"
    delete "sessions/destroy"
    get "dashboards/index"
    get "retailers/index"

    resources :banks
    resources :retailers
    post "retailers/create", to: "retailers#create", as: :retailer_create
    post "retailers/:id/update_status", to: "retailers#update_status", as: :retailer_update_status

    get "wallets/index"
    get "wallets/add_fund"
    post "wallets/add_fund"
    post "wallets/create_fund"


    get "payments/index"
    post "payments/approved"
    post "payments/reject_payment_request"
    get "payments/set_pin"
    post "payments/set_pin_update"
    get "payments/forgot_mpin"
    post "payments/send_mpin_otp"
    get "payments/verify_mpin"
    post "payments/verify_mpin_otp"
    get "payments/set_pin_agin"
    post "payments/set_pin_agin_update"

    get "recharges_and_bills/index"
    get "recharges_and_bills/transaction"
    post "recharges_and_bills/commission_set"

    get "reports/index"
    get "reports/report_filter"
    get "dmts/index"

    get "reset_passwords/reset_password"
    post "reset_passwords/reset_password"
  end

  namespace :master do
    get "dmts/index"
    get "enquery/index"
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

    get "payments/set_pin"
    post "payments/set_pin_update"
    get "payments/forgot_mpin"
    post "payments/send_mpin_otp"
    get "payments/verify_mpin"
    post "payments/verify_mpin_otp"
    get "payments/set_pin_agin"
    post "payments/set_pin_agin_update"

    post "payments/reject_payment_request"

    get "wallets/index"
    get "wallets/add_fund"
    post "wallets/add_fund"
    post "wallets/create_fund"


    get "sessions/login"
    post "sessions/create"
    delete "sessions/destroy"
    get "sessions/forgot_page"
    get "dashboards/index"
    post "sessions/forgot_email"
    get "sessions/opt_page"
    post "sessions/verify_otp"
    get "sessions/set_password"
    post "sessions/set_password"
    get "sessions/otp"
    post "sessions/verify_otp_login"

    get "reset_passwords/reset_page"
    post "reset_passwords/reset_password"
    post "reset_passwords/forget_password"
    post "reset_passwords/main_forget_password"

    get "schemes/index"
    post "schemes/create", to: "schemes#create", as: :admin_scheme_create
    post "schemes/update", to: "schemes#update", as: :admin_scheme_update
    resources :schemes, only: [ :destroy ]

    resources :banks

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
    post "recharges_and_bills/commission_set"


    post "user_services/create", to: "user_services#create", as: :user_services_create
    post "user_services/:id/update_status", to: "user_services#update_status", as: :retailer_update_status
    # resources :user_services
  end

  namespace :admin do
    get "dmts/index"
    get "enquery/index"
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
    post "payments/reject_payment_request"

    get "wallets/index"
    get "wallets/add_fund"
    post "wallets/add_fund"
    post "wallets/create_fund"

    get "sessions/login"
    post "sessions/create"
    delete "sessions/destroy"
    get "sessions/forgot_page"
    get "dashboards/index"
    post "sessions/forgot_email"
    get "sessions/opt_page"
    post "sessions/verify_otp"
    get "sessions/set_password"
    post "sessions/set_password"
    get "sessions/otp"
    post "sessions/verify_otp_login"

    get "reset_passwords/reset_page"
    post "reset_passwords/reset_password"
    post "reset_passwords/forget_password"
    post "reset_passwords/main_forget_password"

    get "schemes/index"
    post "schemes/create", to: "schemes#create", as: :admin_scheme_create
    post "schemes/update", to: "schemes#update", as: :admin_scheme_update
    resources :schemes, only: [ :destroy ]

    resources :banks

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
    post "recharges_and_bills/commission_set"


    post "user_services/create", to: "user_services#create", as: :user_services_create
    # resources :user_services
  end

  namespace :api do
    namespace :v1 do
      namespace :admin do
        get "dashboards/index"

        get  "accounts/credit_logs", to: "accounts#credit_logs"
        post "accounts/add_credit",  to: "accounts#add_credit"

        get  "accounts/debit_logs",  to: "accounts#debit_logs"
        post "accounts/add_debit",   to: "accounts#add_debit"

        resources :user_services do
          member do
            put :update_status
          end
          collection do
            get :service_list
            get :scheme_list
            get :scheme_role
            get :role_list
            post :master_role
            post :dealer_role
            get :scheme_role
            get :role_count
          end
        end

        resources :enqueries, only: [ :index ]


        resources :schemes
        post :scheme_list, to: "schemes#scheme_list", as: :admin_scheme_list

        resources :staffs
        resources :banks
        resources :wallets, only: [ :index, :create ] do
          collection do
            get :bank
            get :bank_details
            get :admin_bank
            get :wallet_history
            get :legal_balance
          end
        end

        resources :admin_profiles do
          collection do
            post "set_pin"
            post "reset_transaction_pin"
            post "forget_transaction_pin"
            post "verfiy_transaction_pin"

            post "set_password"
            post "forgot_password"
            post "verify_password_otp"
            post "forget_password"
            post "main_forget_password"
            post "set_mpin"
          end
        end

        resources :commissions do
          collection do
            post "commission_operator"
            post "show_commission"
            get "scheme_list"
            post "set_commission"
            post "service_category"
            post "service_product"
          end
        end

        resources :payments do
          collection do
            post "index"
            post "approved"
            post "reject_payment_request"
          end
        end

        resources :support_tickets, only: [ :create, :index, :show ] do
          patch :update_status, on: :member
        end
        resources :staffs
        resources :tasks
        resources :departments
        resources :legal_commissions

        post "reports/index"
        post "reports/loan_report"
        # resources :reports , only: [:index]

        resources :refunds, only: [ :index, :create ] do
          post :refund_transaction, on: :member
        end

        get "personal_loans/list"

        post "personal_loans/update_loan_status"
        post "personal_loans/approved_loan_status"
      end
    end
  end

  namespace :api do
    namespace :v1 do
      namespace :auth do
        # LOGIN (Admin / Master / Dealer / Agent)
        post "login", to: "sessions#login"

        # VERIFY OTP
        post "verify_email", to: "sessions#verify_email"

        # CREATE USER (Retailer / Agent / Dealer)
        post "register", to: "sessions#create"

        post "verify_registration_email", to: "sessions#verify_registration_email"


        # ROLE LIST
        get "roles", to: "sessions#role"
      end
    end
  end

  namespace :api do
    namespace :v1 do
      namespace :customer do
        get "locations/index"

        post "sessions/login_email"
        post "sessions/email_verify"
        post "sessions/login"
        post "sessions/verify_otp"

        post "kycs/user_details"
        post "kycs/aadhaar_otp", to: "kycs#aadhaar_otp"
        post "kycs/verify_aadhaar_otp", to: "kycs#verify_aadhaar_otp"
        post "kycs/manual_aadhaar_upload", to: "kycs#manual_aadhaar_upload"
        post "kycs/pencard_otp", to: "kycs#pencard_otp"
        post "kycs/verify_pencard_otp", to: "kycs#verify_pencard_otp"
        post "kycs/pan_image_upload"
        post "kycs/selfie", to: "kycs#selfie"
        get "kycs/kyc_details", to: "kycs#kyc_details"
        post "kycs/submit_kyc_details", to: "kycs#submit_kyc_details"

        post "set_mpins/mpin"
        post "set_mpins/set_mpin"
        post "set_mpins/forget_mpin"
        post "set_mpins/verify_forget_mpin"

        post "recharges/create"
      end

      namespace :master do
        get "dashboards/index"
      end

      namespace :agent do
        get "/eko/check_kyc", to: "eko#check_kyc"

        get "dashboards/index"
        get "dashboards/dashboard_data"
        post "sessions/login"
        post "sessions/create"
        get "sessions/role"
        post "sessions/verify_email"
        post "enquires/create"
        post "enquires/verify_email"

        get "user_services/index"
        post "user_services/service_category"
        post "user_services/service_product"
        get "user_services/earn_commission"
        post "user_services/transaction_list"

        post "recharges/recharge"
        post "recharges/recharge_list"
        post "recharges/verify_pin"
        get "recharges/bill_fetch_category"
        post "fetch_eko_operators", to: "recharges#fetch_eko_operators"
        get "operators_category", to: "recharges#operators_category"
        get "fetch_eko_locations", to: "recharges#fetch_eko_locations"
        post "fetch_eko_plans", to: "recharges#fetch_eko_plans"
        post "eko_mobile_recharge", to: "recharges#eko_mobile_recharge"
        get "activate_eko_service", to: "recharges#activate_eko_service"
        post "activate_eko_service_ar", to: "recharges#activate_eko_service_ar"
        post "activate_bbps_service", to: "recharges#activate_bbps_service"
        post "create", to: "recharges#create"
        post "paybill", to: "recharges#paybill"
        post "fetch_bill", to: "recharges#fetch_bill"

        post "fetch_plans", to: "recharges#fetch_plans"
        post "recharges/fetch_eko_user_info"

        get "wallets/balance"
        post "wallets/create"
        post "wallets/fund_request_list"
        get "wallets/bank_list"
        post "wallets/bank_details"
        get "wallets/wallet_history"
        get "wallets/agent_bank"

        post "filters/category_filter"
        post "filters/service_category_filter"
        post "filters/service_product"
        post "filters/loan_report"

        post "instant_loans/check_eligibility"
        post "personal_loans/check_eligibility"
        get "instant_loans/instant_loan_list"
        get "personal_loans/persoanl_loan_list"
        post "personal_loans/get_offer"

        resources :home_loans, only: [:create, :index] do
          collection do
            post :get_offer
          end
        end

        resources :gold_loans, only: [:create, :index] do
          collection do
            post :get_offer
          end
        end

        resources :staffs
        resources :leads

        resources :reatailer_profiles, only: [ :index ]
        get "reatailer_profiles/user_profile"
        post "reatailer_profiles/set_pin"
        post "reatailer_profiles/reset_transaction_pin"
        post "reatailer_profiles/forget_transaction_pin"
        post "reatailer_profiles/verfiy_transaction_pin"

        post "reatailer_profiles/set_password"
        post "reatailer_profiles/reset_password"
        post "reatailer_profiles/forget_password"
        post "reatailer_profiles/main_forget_password"
        post "reatailer_profiles/set_mpin"

        post "commission_reports/index"
        get "commission_reports/earn_commission"

        get "dmts/dmt_transactions_list"
        post "dmts/sender_details"
        post "dmts/verify_eko_otp"
        post "dmts/dmt_transactions"
        post "dmts/dmt_transaction_verify"
        post "dmts/update_dmt_transaction"
        post "dmts/benfisries_dmt_transaction"
        post "dmts/beneficiary_fetch"
        get "dmts/beneficiary_list"
        post "dmts/user_onboard"
        post "dmts/check_profile"
        post "dmts/create_customer"
        post "dmts/verify_otp"
        get "dmts/bank_list"
        post "dmts/send_ekodmt_otp"
        post "biometric_ekyc_otp_verify", to: "dmts#biometric_ekyc_otp_verify"
        post "biometric", to: "dmts#biometric"
        post "biometric_kyc", to: "dmts#biometric_kyc"
        resources :support_tickets, only: [ :create, :index, :show ] do
          patch :update_status, on: :member
        end
        # bbsp api code
        get "bbps/bbps_category"
        post "bbps/bbps_operators"
        get "bbps/bbps_locations"
        post "bbps/bbps_fetch_bill"
        post "bbps/recharge"

        # api code for fund request
        post "eko_fund_requests/create"
        get "eko_fund_requests/bank"
        get "eko_fund_requests/balance_api"

        resources :refunds, only: [:index, :create] do
          post :refund_transaction, on: :collection
          post :refund_verify_otp, on: :collection
        end
        
        resources :legal_services, only: [:index]
        resources :payments
        #
      end
    end
  end


  root "superadmin/dashboards#index"

  namespace :superadmin do
    get "reset_passwords/reset_password"
    post "reset_passwords/reset_password"
    get "sessions/login"
    post "sessions/create"
    delete "sessions/destroy"
    get "sessions/forgot_page"
    post "sessions/forgot_email"
    get "sessions/opt_page"
    post "sessions/verify_otp"
    get "sessions/set_password"
    post "sessions/set_password"
    get "sessions/otp"
    post "sessions/verify_otp_login"

    get "financial_services/index"
    get "customer/index"
    post "customer/verify_status"

    get "reports/index"

    get "commissions/index"
    get "commissions/commission_filter"
    post "commissions/set_commission"
    get "commissions/new"
    get "commissions/service_list"
    resources :commissions

    get "accounts/index"
    get "accounts/new"
    post "accounts/add_credit"
    get "accounts/debit_index"
    post "accounts/add_debit"

    post "payments/approved"
    get "payments/index"
    get "payments/set_pin"
    post "payments/set_pin_update"
    get "payments/forgot_mpin"
    post "payments/send_mpin_otp"
    get "payments/verify_mpin"
    post "payments/verify_mpin_otp"
    get "payments/set_pin_agin"
    post "payments/set_pin_agin_update"
    post "payments/reject_payment_request"

    get "blance/index"
    get "categories/index"
    get "recharge_and_bill/index"
    get "recharge_and_bill/transaction"
    get "recharge_and_bill/view"
    post "recharge_and_bill/commission_set"

    get "retailers/export"

    get "service/index"
    get "enqueries/index"


    get "scheme/index"
    post "scheme/create", to: "scheme#create", as: :scheme_create
    post "scheme/update", to: "scheme#update", as: :scheme_update

    resources :scheme, only: [ :destroy ]

    post "admins/create", to: "admins#create", as: :admins_create
    post "admins/:id/admin_update_stauts", to: "admins#admin_update_stauts", as: :admin_update_status

    get  "travel_and_stay_report/travel_report"

    resources :admins
    resources :banks
    resources :services
    resources :categories
    resources :service_products do
      member do
        get :view_product_item
        get :new_prodcut_item
        post :prodcut_item_create
        get :prodcut_item_edit
        post :prodcut_item_update
        delete :prodcut_item_destroy
      end
    end

    resources :legal_commissions
    get "fetch_categories", to: "legal_commissions#fetch_categories"


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
