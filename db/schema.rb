# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20090924125806) do

  create_table "interested_people", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "invited_people", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.integer  "interested_person_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "locales", :force => true do |t|
    t.string "code"
    t.string "name"
  end

  add_index "locales", ["code"], :name => "index_locales_on_code"

  create_table "memberships", :force => true do |t|
    t.integer  "user_id"
    t.string   "organisation"
    t.string   "position"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles", :force => true do |t|
    t.string   "name",              :limit => 40
    t.string   "authorizable_type", :limit => 40
    t.integer  "authorizable_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles_users", :id => false, :force => true do |t|
    t.integer  "user_id"
    t.integer  "role_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "translations", :force => true do |t|
    t.string  "key"
    t.string  "raw_key"
    t.text    "value"
    t.integer "pluralization_index", :default => 1
    t.integer "locale_id"
  end

  add_index "translations", ["locale_id", "key", "pluralization_index"], :name => "index_translations_on_locale_id_and_key_and_pluralization_index"
  add_index "translations", ["locale_id", "raw_key"], :name => "index_translations_on_locale_id_and_raw_key"

  create_table "users", :force => true do |t|
    t.string   "email",                                   :null => false
    t.string   "crypted_password"
    t.string   "password_salt"
    t.string   "persistence_token",                       :null => false
    t.string   "perishable_token",                        :null => false
    t.integer  "login_count",          :default => 0,     :null => false
    t.integer  "failed_login_count",   :default => 0,     :null => false
    t.datetime "last_request_at"
    t.datetime "current_login_at"
    t.datetime "last_login_at"
    t.string   "current_login_ip"
    t.string   "last_login_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "active",               :default => false, :null => false
    t.string   "openid_identifier"
    t.string   "picture_file_name"
    t.string   "picture_content_type"
    t.integer  "picture_file_size"
    t.datetime "picture_updated_at"
    t.string   "name"
    t.string   "prename"
    t.boolean  "gender"
  end

  create_table "web_profiles", :force => true do |t|
    t.string   "sort"
    t.string   "location"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "web_profiles", ["user_id"], :name => "index_web_profiles_on_user_id"

end
