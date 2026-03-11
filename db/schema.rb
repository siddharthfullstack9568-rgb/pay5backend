# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.2].define(version: 2026_03_09_090614) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "account_transactions", force: :cascade do |t|
    t.string "txn_id"
    t.decimal "amount"
    t.string "reason"
    t.string "user_code"
    t.string "mobile"
    t.string "txn_type"
    t.string "user_type"
    t.string "user_name"
    t.string "status"
    t.integer "parent_id"
    t.bigint "user_id", null: false
    t.bigint "wallet_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["parent_id"], name: "index_account_transactions_on_parent_id"
    t.index ["user_id"], name: "index_account_transactions_on_user_id"
    t.index ["wallet_id"], name: "index_account_transactions_on_wallet_id"
  end

  create_table "api_clients", force: :cascade do |t|
    t.string "name"
    t.string "user_code", null: false
    t.string "api_key", null: false
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["api_key"], name: "index_api_clients_on_api_key", unique: true
    t.index ["user_code"], name: "index_api_clients_on_user_code", unique: true
  end

  create_table "banks", force: :cascade do |t|
    t.string "bank_name"
    t.string "account_name"
    t.string "ifsc_code"
    t.string "account_number"
    t.string "account_type"
    t.string "first_name"
    t.string "last_name"
    t.decimal "initial_balance"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.index ["user_id"], name: "index_banks_on_user_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "title"
    t.string "image"
    t.boolean "status"
    t.bigint "service_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["service_id"], name: "index_categories_on_service_id"
  end

  create_table "commissions", force: :cascade do |t|
    t.string "commission_type"
    t.string "from_role"
    t.string "to_role"
    t.decimal "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "service_product_item_id", null: false
    t.bigint "scheme_id"
    t.decimal "commission_rate"
    t.index ["scheme_id"], name: "index_commissions_on_scheme_id"
    t.index ["service_product_item_id"], name: "index_commissions_on_service_product_item_id"
  end

  create_table "dmt_transactions", force: :cascade do |t|
    t.bigint "dmt_id", null: false
    t.bigint "user_id", null: false
    t.string "status"
    t.string "txn_id"
    t.string "sender_mobile_number"
    t.string "bank_name"
    t.string "account_number"
    t.string "amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "parent_id"
    t.index ["dmt_id"], name: "index_dmt_transactions_on_dmt_id"
    t.index ["parent_id"], name: "index_dmt_transactions_on_parent_id"
    t.index ["user_id"], name: "index_dmt_transactions_on_user_id"
  end

  create_table "dmts", force: :cascade do |t|
    t.string "full_name"
    t.string "account_number"
    t.string "confirm_account_number"
    t.string "phone_number"
    t.string "bank_name"
    t.string "branch_name"
    t.string "ifsc_code"
    t.string "sender_full_name"
    t.string "sender_phone_number"
    t.string "sender_aadhar_number"
    t.string "sender_aadhar_otp_email"
    t.boolean "beneficiaries_status", default: false
    t.string "sender_name"
    t.string "receiver_name"
    t.string "sender_mobile_number"
    t.string "receiver_mobile_number"
    t.string "status"
    t.string "aadhaar_number_otp"
    t.string "aadhaar_number_otp_expriry"
    t.string "datetime"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "amount"
    t.integer "parent_id"
    t.string "customer_id"
    t.bigint "recipient_id"
    t.decimal "fee"
    t.string "tid"
    t.decimal "tds"
    t.decimal "service_tax"
    t.decimal "commission"
    t.string "txstatus_desc"
    t.decimal "collectable_amount"
    t.bigint "user_id"
    t.index ["parent_id"], name: "index_dmts_on_parent_id"
    t.index ["user_id"], name: "index_dmts_on_user_id"
  end

  create_table "eko_banks", force: :cascade do |t|
    t.string "bank_id"
    t.string "name"
    t.string "ifsc_prefix"
    t.string "bank_code"
    t.boolean "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "enquiries", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.string "phone_number"
    t.string "aadhaar_number"
    t.string "pan_card"
    t.boolean "status", default: false
    t.bigint "role_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["role_id"], name: "index_enquiries_on_role_id"
  end

  create_table "fund_requests", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.integer "requested_by"
    t.decimal "amount"
    t.string "status"
    t.integer "approved_by"
    t.datetime "approved_at"
    t.string "remark"
    t.string "image"
    t.string "transaction_type"
    t.string "mode"
    t.string "bank_reference_no"
    t.string "payment_mode"
    t.string "deposit_bank"
    t.string "your_bank"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "reject_note"
    t.string "account_number"
    t.string "deposit_account_no"
    t.string "deposit_ifsc_code"
    t.string "ifsc_code"
    t.index ["user_id"], name: "index_fund_requests_on_user_id"
  end

  create_table "gold_loans", force: :cascade do |t|
    t.string "mobile_number"
    t.string "first_name"
    t.string "last_name"
    t.string "pan"
    t.string "email"
    t.string "pincode"
    t.decimal "loan_amount"
    t.datetime "consumer_consent_date"
    t.string "consumer_consent_ip"
    t.string "utm_id"
    t.string "utm_campaign"
    t.string "utm_source"
    t.string "utm_medium"
    t.string "utm_content"
    t.string "utm_term"
    t.string "pid"
    t.string "sub_id1"
    t.string "sub_id2"
    t.string "sub_id3"
    t.string "lead_id"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_gold_loans_on_user_id"
  end

  create_table "houseloans", force: :cascade do |t|
    t.string "mobile_number"
    t.string "first_name"
    t.string "last_name"
    t.string "pan"
    t.date "dob"
    t.string "email"
    t.string "pincode"
    t.decimal "monthly_income"
    t.decimal "housing_loan_amount"
    t.string "property_type"
    t.datetime "consumer_consent_date"
    t.string "consumer_consent_ip"
    t.string "utm_id"
    t.string "utm_campaign"
    t.string "utm_source"
    t.string "utm_medium"
    t.string "utm_content"
    t.string "utm_term"
    t.string "pid"
    t.string "sub_id1"
    t.string "sub_id2"
    t.string "sub_id3"
    t.string "lead_id"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_houseloans_on_user_id"
  end

  create_table "instant_loans", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.string "employee_status"
    t.string "mobile"
    t.date "dob"
    t.string "pan_number"
    t.string "aadhaar_number"
    t.decimal "monthly_income"
    t.integer "credit_score"
    t.boolean "fetch_credit_score"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "status"
    t.text "pending_note"
    t.bigint "user_id"
    t.index ["user_id"], name: "index_instant_loans_on_user_id"
  end

  create_table "personal_loans", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.string "mobile"
    t.date "dob"
    t.string "pan_number"
    t.string "aadhaar_number"
    t.string "employee_status"
    t.string "employer_name"
    t.string "office_pin_code"
    t.decimal "monthly_income"
    t.integer "credit_score"
    t.boolean "fetch_credit_score"
    t.string "pincode"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "status"
    t.text "pending_note"
    t.bigint "user_id"
    t.string "lead_id"
    t.index ["lead_id"], name: "index_personal_loans_on_lead_id"
    t.index ["user_id"], name: "index_personal_loans_on_user_id"
  end

  create_table "refund_requests", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "transaction_id"
    t.bigint "parent_id"
    t.string "refund_id"
    t.string "refund_type"
    t.decimal "amount", precision: 15, scale: 2
    t.text "reason"
    t.string "status"
    t.text "admin_note"
    t.datetime "processed_at"
    t.integer "processed_by"
    t.string "attachment_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["parent_id"], name: "index_refund_requests_on_parent_id"
    t.index ["transaction_id"], name: "index_refund_requests_on_transaction_id"
    t.index ["user_id"], name: "index_refund_requests_on_user_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "schemes", force: :cascade do |t|
    t.string "scheme_name"
    t.string "scheme_type"
    t.decimal "commision_rate"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.index ["user_id"], name: "index_schemes_on_user_id"
  end

  create_table "service_product_items", force: :cascade do |t|
    t.string "name"
    t.string "oprator_type"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "category_id"
    t.bigint "operator_id"
    t.index ["category_id"], name: "index_service_product_items_on_category_id"
    t.index ["operator_id"], name: "index_service_product_items_on_operator_id"
  end

  create_table "service_products", force: :cascade do |t|
    t.string "company_name"
    t.decimal "admin_commission"
    t.decimal "master_commission"
    t.decimal "dealer_commission"
    t.decimal "retailer_commission"
    t.bigint "category_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_service_products_on_category_id"
  end

  create_table "services", force: :cascade do |t|
    t.string "title"
    t.boolean "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "logo"
    t.integer "position"
  end

  create_table "support_tickets", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "ticket_number"
    t.string "full_name"
    t.string "email"
    t.string "service_type"
    t.string "reference_id"
    t.string "subject"
    t.text "description"
    t.string "status"
    t.datetime "status_updated_at"
    t.text "resolution_note"
    t.datetime "resolved_at"
    t.integer "assigned_agent_id"
    t.string "attachment_url"
    t.integer "parent_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["parent_id"], name: "index_support_tickets_on_parent_id"
    t.index ["user_id"], name: "index_support_tickets_on_user_id"
  end

  create_table "transaction_commissions", force: :cascade do |t|
    t.bigint "transaction_id", null: false
    t.bigint "user_id", null: false
    t.integer "role"
    t.decimal "commission_amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "service_product_item_id"
    t.index ["service_product_item_id"], name: "index_transaction_commissions_on_service_product_item_id"
    t.index ["transaction_id"], name: "index_transaction_commissions_on_transaction_id"
    t.index ["user_id"], name: "index_transaction_commissions_on_user_id"
  end

  create_table "transactions", force: :cascade do |t|
    t.string "tx_id"
    t.string "operator"
    t.string "transaction_type"
    t.string "account_or_mobile"
    t.decimal "amount"
    t.string "status"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "consumer_name"
    t.string "subscriber_or_vc_number"
    t.string "bill_no"
    t.string "landline_no"
    t.string "std_code"
    t.string "consumer_no"
    t.string "bank"
    t.string "mobile"
    t.string "vehicle_no"
    t.string "payment_method"
    t.string "ifsc_code"
    t.string "pan"
    t.string "upi_id"
    t.string "receiver_name"
    t.string "card_number"
    t.string "state"
    t.string "tid"
    t.decimal "tds", precision: 10, scale: 2
    t.decimal "commission", precision: 10, scale: 2
    t.string "status_text"
    t.string "txstatus_desc"
    t.bigint "category_id"
    t.index ["category_id"], name: "index_transactions_on_category_id"
    t.index ["user_id"], name: "index_transactions_on_user_id"
  end

  create_table "user_services", force: :cascade do |t|
    t.bigint "assigner_id", null: false
    t.bigint "assignee_id", null: false
    t.bigint "service_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["assignee_id"], name: "index_user_services_on_assignee_id"
    t.index ["assigner_id", "assignee_id", "service_id"], name: "idx_on_assigner_id_assignee_id_service_id_befeb9b84f", unique: true
    t.index ["assigner_id"], name: "index_user_services_on_assigner_id"
    t.index ["service_id"], name: "index_user_services_on_service_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.string "password_digest"
    t.integer "role"
    t.integer "otp"
    t.integer "verify_otp"
    t.datetime "otp_expires_at"
    t.string "phone_number"
    t.string "country_code"
    t.string "alternative_number"
    t.string "aadhaar_number"
    t.string "pan_card"
    t.date "date_of_birth"
    t.string "gender"
    t.string "business_name"
    t.string "business_owner_type"
    t.string "business_nature_type"
    t.string "business_registration_number"
    t.string "gst_number"
    t.string "pan_number"
    t.text "address"
    t.string "city"
    t.string "state"
    t.string "pincode"
    t.string "landmark"
    t.string "username"
    t.string "scheme"
    t.string "referred_by"
    t.string "bank_name"
    t.string "account_number"
    t.string "ifsc_code"
    t.string "account_holder_name"
    t.text "notes"
    t.text "session_token"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "role_id", default: 1, null: false
    t.boolean "status", default: false
    t.string "company_type"
    t.string "company_name"
    t.string "cin_number"
    t.string "registration_certificate"
    t.integer "user_admin_id"
    t.string "confirm_password"
    t.string "domain_name"
    t.bigint "scheme_id"
    t.bigint "service_id"
    t.string "pan_card_image"
    t.string "aadhaar_image"
    t.string "passport_photo"
    t.string "store_shop_photo"
    t.string "address_proof_photo"
    t.integer "parent_id"
    t.string "set_pin"
    t.string "confirm_pin"
    t.decimal "latitude", precision: 10, scale: 6
    t.decimal "longitude", precision: 10, scale: 6
    t.datetime "captured_at"
    t.datetime "last_seen_at"
    t.string "ip_address"
    t.string "location"
    t.string "kyc_status", default: "not_started"
    t.string "kyc_method"
    t.string "aadhaar_front_image"
    t.string "aadhaar_back_image"
    t.string "aadhaar_otp"
    t.string "pan_otp"
    t.string "pan_status", default: "not_started"
    t.string "aadhaar_status", default: "not_started"
    t.string "image"
    t.boolean "kyc_verifications", default: false
    t.datetime "kyc_verified_at"
    t.jsonb "kyc_data", default: {}, null: false
    t.string "email_otp"
    t.datetime "email_otp_sent_at"
    t.string "set_mpin"
    t.string "confirm_mpin"
    t.boolean "status_mpin", default: false
    t.boolean "status_pin", default: false
    t.boolean "email_otp_status", default: false, null: false
    t.datetime "email_otp_verified_at"
    t.boolean "set_pin_status", default: false
    t.string "user_code"
    t.boolean "eko_onboard_first_step", default: false
    t.boolean "eko_profile_second_step", default: false
    t.boolean "eko_status_otp", default: false
    t.boolean "eko_verify_otp", default: false
    t.boolean "eko_biometric_kyc", default: false
    t.string "permanent_address"
    t.string "permanent_landmark"
    t.string "permanent_postal_code"
    t.string "permanent_city"
    t.string "permanent_state"
    t.string "permanent_pincode"
    t.index ["email"], name: "index_users_on_email"
    t.index ["parent_id"], name: "index_users_on_parent_id"
    t.index ["role_id"], name: "index_users_on_role_id"
    t.index ["scheme_id"], name: "index_users_on_scheme_id"
    t.index ["service_id"], name: "index_users_on_service_id"
  end

  create_table "wallet_histories", force: :cascade do |t|
    t.bigint "wallet_id", null: false
    t.integer "user_id"
    t.integer "parent_id"
    t.decimal "amount"
    t.decimal "before_balance"
    t.decimal "after_balance"
    t.string "transaction_type"
    t.string "remark"
    t.string "reference_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["wallet_id"], name: "index_wallet_histories_on_wallet_id"
  end

  create_table "wallet_transactions", force: :cascade do |t|
    t.bigint "wallet_id", null: false
    t.string "tx_id", limit: 50, null: false
    t.string "mode", null: false
    t.string "transaction_type", null: false
    t.decimal "amount", precision: 12, scale: 2, null: false
    t.string "status", default: "pending"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "fund_request_id", null: false
    t.index ["fund_request_id"], name: "index_wallet_transactions_on_fund_request_id"
    t.index ["wallet_id"], name: "index_wallet_transactions_on_wallet_id"
  end

  create_table "wallets", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.decimal "balance"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_wallets_on_user_id"
  end

  add_foreign_key "account_transactions", "users"
  add_foreign_key "account_transactions", "wallets"
  add_foreign_key "banks", "users"
  add_foreign_key "categories", "services"
  add_foreign_key "commissions", "schemes"
  add_foreign_key "commissions", "service_product_items"
  add_foreign_key "dmt_transactions", "dmts"
  add_foreign_key "dmt_transactions", "users"
  add_foreign_key "dmts", "users"
  add_foreign_key "enquiries", "roles"
  add_foreign_key "fund_requests", "users"
  add_foreign_key "gold_loans", "users"
  add_foreign_key "houseloans", "users"
  add_foreign_key "instant_loans", "users"
  add_foreign_key "personal_loans", "users"
  add_foreign_key "refund_requests", "users"
  add_foreign_key "schemes", "users"
  add_foreign_key "service_product_items", "categories"
  add_foreign_key "service_products", "categories"
  add_foreign_key "support_tickets", "users"
  add_foreign_key "transaction_commissions", "service_product_items"
  add_foreign_key "transaction_commissions", "transactions"
  add_foreign_key "transaction_commissions", "users"
  add_foreign_key "transactions", "categories"
  add_foreign_key "transactions", "users"
  add_foreign_key "user_services", "services"
  add_foreign_key "user_services", "users", column: "assignee_id"
  add_foreign_key "user_services", "users", column: "assigner_id"
  add_foreign_key "users", "roles"
  add_foreign_key "users", "schemes"
  add_foreign_key "users", "services"
  add_foreign_key "wallet_histories", "wallets"
  add_foreign_key "wallet_transactions", "fund_requests"
  add_foreign_key "wallet_transactions", "wallets"
  add_foreign_key "wallets", "users"
end
