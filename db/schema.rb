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

ActiveRecord::Schema.define(:version => 20100201181239) do

  create_table "concernments", :force => true do |t|
    t.integer  "user_id"
    t.integer  "tag_id"
    t.integer  "sort"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "concernments", ["sort"], :name => "index_concernments_on_sort"
  add_index "concernments", ["user_id", "sort"], :name => "index_concernments_on_user_id_and_sort"

  create_table "echo_details", :force => true do |t|
    t.integer "echo_id"
    t.integer "user_id"
    t.boolean "visited",   :default => false
    t.boolean "supported", :default => false
  end

  add_index "echo_details", ["echo_id"], :name => "index_echo_details_on_echo_id"
  add_index "echo_details", ["user_id"], :name => "index_echo_details_on_user_id"

  create_table "echos", :force => true do |t|
    t.integer "visitor_count",   :default => 0
    t.integer "supporter_count", :default => 0
  end

  create_table "feedbacks", :force => true do |t|
    t.string "name"
    t.string "email"
    t.string "message"
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

  create_table "profiles", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.boolean  "female"
    t.string   "city"
    t.string   "country"
    t.text     "about_me"
    t.text     "motivation"
    t.date     "birthday"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.float    "completeness",        :default => 0.1
  end

  create_table "reports", :force => true do |t|
    t.integer  "reporter_id"
    t.integer  "suspect_id"
    t.text     "reason"
    t.boolean  "done",        :default => false
    t.text     "decision"
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

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "statement_documents", :force => true do |t|
    t.string  "title"
    t.text    "text"
    t.integer "author_id"
  end

  create_table "statements", :force => true do |t|
    t.string   "type"
    t.integer  "parent_id"
    t.integer  "root_id"
    t.integer  "document_id"
    t.integer  "creator_id"
    t.integer  "work_package_id"
    t.integer  "echo_id"
    t.integer  "category_id"
    t.integer  "state"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tags", :force => true do |t|
    t.string   "value"
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
    t.string   "email",                                 :null => false
    t.string   "crypted_password"
    t.string   "password_salt"
    t.string   "persistence_token",                     :null => false
    t.string   "perishable_token",                      :null => false
    t.integer  "login_count",        :default => 0,     :null => false
    t.integer  "failed_login_count", :default => 0,     :null => false
    t.datetime "last_request_at"
    t.datetime "current_login_at"
    t.datetime "last_login_at"
    t.string   "current_login_ip"
    t.string   "last_login_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "active",             :default => false, :null => false
    t.string   "openid_identifier"
  end

  create_table "web_profiles", :force => true do |t|
    t.integer  "user_id"
    t.string   "location"
    t.integer  "sort"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "web_profiles", ["user_id"], :name => "index_web_profiles_on_user_id"

end
