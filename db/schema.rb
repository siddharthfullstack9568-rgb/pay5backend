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

ActiveRecord::Schema[7.2].define(version: 2025_09_03_113045) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

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
    t.index ["email"], name: "index_users_on_email"
    t.index ["role_id"], name: "index_users_on_role_id"
    t.index ["scheme_id"], name: "index_users_on_scheme_id"
    t.index ["service_id"], name: "index_users_on_service_id"
  end

  add_foreign_key "categories", "services"
  add_foreign_key "enquiries", "roles"
  add_foreign_key "service_products", "categories"
  add_foreign_key "transactions", "users"
  add_foreign_key "user_services", "services"
  add_foreign_key "user_services", "users", column: "assignee_id"
  add_foreign_key "user_services", "users", column: "assigner_id"
  add_foreign_key "users", "roles"
  add_foreign_key "users", "schemes"
  add_foreign_key "users", "services"
end
