# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20190826215828) do

  create_table "accounts", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",        default: 0,  null: false
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "accounts", ["confirmation_token"], name: "index_accounts_on_confirmation_token", unique: true
  add_index "accounts", ["email"], name: "index_accounts_on_email", unique: true
  add_index "accounts", ["reset_password_token"], name: "index_accounts_on_reset_password_token", unique: true
  add_index "accounts", ["unlock_token"], name: "index_accounts_on_unlock_token", unique: true

  create_table "bills", force: :cascade do |t|
    t.date     "date"
    t.decimal  "amount",           precision: 6, scale: 2
    t.decimal  "total_data",       precision: 6, scale: 3
    t.decimal  "data_cost",        precision: 6, scale: 2
    t.integer  "account_id",                                             null: false
    t.decimal  "balance",          precision: 6, scale: 2
    t.decimal  "data_subtotal",    precision: 6, scale: 3, default: 0.0
    t.decimal  "percent_total",    precision: 5, scale: 2, default: 0.0
    t.decimal  "data_share_total", precision: 6, scale: 2, default: 0.0
    t.decimal  "surcharges_total", precision: 6, scale: 2, default: 0.0
    t.decimal  "subtotal",         precision: 6, scale: 2, default: 0.0
    t.datetime "created_at",                                             null: false
    t.datetime "updated_at",                                             null: false
  end

  add_index "bills", ["account_id"], name: "index_bills_on_account_id"

  create_table "charges", force: :cascade do |t|
    t.integer  "bill_id"
    t.integer  "user_id"
    t.integer  "account_id",                                              null: false
    t.decimal  "surcharges",      precision: 6, scale: 2
    t.decimal  "data_used",       precision: 6, scale: 3
    t.decimal  "data_percentage", precision: 6, scale: 4
    t.decimal  "data_share",      precision: 6, scale: 2
    t.decimal  "personal_total",  precision: 6, scale: 2
    t.boolean  "paid",                                    default: false, null: false
    t.date     "date"
    t.datetime "created_at",                                              null: false
    t.datetime "updated_at",                                              null: false
  end

  add_index "charges", ["account_id"], name: "index_charges_on_account_id"
  add_index "charges", ["bill_id"], name: "index_charges_on_bill_id"
  add_index "charges", ["user_id"], name: "index_charges_on_user_id"

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.integer  "account_id"
    t.text     "message"
    t.decimal  "balance",    precision: 6, scale: 2, default: 0.0
    t.datetime "created_at",                                       null: false
    t.datetime "updated_at",                                       null: false
    t.integer  "manager_id"
  end

  add_index "users", ["account_id"], name: "index_users_on_account_id"
  add_index "users", ["manager_id"], name: "index_users_on_manager_id"

end
