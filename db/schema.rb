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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120419075508) do

  create_table "lettre_orders", :force => true do |t|
    t.integer  "user_id"
    t.date     "preferred_delivery_date"
    t.string   "signed_name"
    t.date     "message_display_date"
    t.text     "message"
    t.datetime "created_at",                                 :null => false
    t.datetime "updated_at",                                 :null => false
    t.string   "address_street1"
    t.string   "address_street2"
    t.string   "address_city"
    t.string   "address_state"
    t.string   "address_zip"
    t.integer  "paper_size",              :default => 0
    t.integer  "writing_style",           :default => 0
    t.boolean  "wax_seal",                :default => false
    t.string   "uuid"
    t.boolean  "doodle",                  :default => false
    t.boolean  "lipstick",                :default => false
    t.boolean  "teardrops",               :default => false
    t.boolean  "in_person",               :default => false
  end

  add_index "lettre_orders", ["user_id"], :name => "index_lettre_orders_on_user_id"
  add_index "lettre_orders", ["uuid"], :name => "index_lettre_orders_on_uuid"

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "password_salt"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",        :default => 0
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.string   "authentication_token"
    t.string   "username"
    t.boolean  "admin"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "users", ["authentication_token"], :name => "index_users_on_authentication_token", :unique => true
  add_index "users", ["confirmation_token"], :name => "index_users_on_confirmation_token", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true
  add_index "users", ["unlock_token"], :name => "index_users_on_unlock_token", :unique => true
  add_index "users", ["username"], :name => "index_users_on_username", :unique => true

end
