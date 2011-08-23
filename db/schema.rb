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

ActiveRecord::Schema.define(:version => 20110814214204) do

  create_table "books", :force => true do |t|
    t.string   "isbn"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "creator_types", :force => true do |t|
    t.string   "name"
    t.integer  "item_type_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "creator_types", ["item_type_id"], :name => "index_creator_types_on_item_type_id"

  create_table "creators", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "creators", ["name"], :name => "index_creators_on_name"

  create_table "full_texts", :force => true do |t|
    t.text     "text"
    t.integer  "textable_id"
    t.string   "textable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "item_creators", :force => true do |t|
    t.integer  "item_id"
    t.integer  "creator_id"
    t.integer  "creator_type_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "item_creators", ["creator_id"], :name => "index_item_creators_on_creator_id"
  add_index "item_creators", ["creator_type_id"], :name => "index_item_creators_on_creator_type_id"
  add_index "item_creators", ["item_id"], :name => "index_item_creators_on_item_id"

  create_table "item_keys", :force => true do |t|
    t.integer  "item_id"
    t.integer  "key_type_id"
    t.string   "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "item_keys", ["item_id"], :name => "index_item_keys_on_item_id"
  add_index "item_keys", ["key_type_id"], :name => "index_item_keys_on_key_type_id"

  create_table "item_metadata", :force => true do |t|
    t.integer  "item_id"
    t.integer  "metadatum_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "item_metadata", ["item_id"], :name => "index_item_metadata_on_item_id"
  add_index "item_metadata", ["metadatum_id"], :name => "index_item_metadata_on_metadatum_id"

  create_table "item_types", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "items", :force => true do |t|
    t.string   "name"
    t.float    "rating"
    t.integer  "year"
    t.integer  "item_type_id"
    t.string   "location"
    t.string   "artwork"
    t.date     "publication_date"
    t.string   "image"
    t.string   "image_width"
    t.string   "image_height"
    t.string   "thumbnail"
    t.integer  "thumbnail_height"
    t.integer  "thumbnail_width"
    t.string   "itemable_type"
    t.string   "string"
    t.integer  "itemable_id"
    t.integer  "integer"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "items", ["item_type_id"], :name => "index_items_on_item_type_id"
  add_index "items", ["itemable_id"], :name => "index_items_on_itemable_id"
  add_index "items", ["name"], :name => "index_items_on_name"
  add_index "items", ["rating"], :name => "index_items_on_rating"
  add_index "items", ["year"], :name => "index_items_on_year"

  create_table "key_types", :force => true do |t|
    t.string   "name"
    t.integer  "item_type_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "key_types", ["item_type_id"], :name => "index_key_types_on_item_type_id"

  create_table "metadata", :force => true do |t|
    t.integer  "metadata_type_id"
    t.string   "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "metadata_types", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                               :default => "", :null => false
    t.string   "encrypted_password",   :limit => 128, :default => "", :null => false
    t.string   "password_salt",                       :default => "", :null => false
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "reset_password_token"
    t.string   "remember_token"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                       :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["confirmation_token"], :name => "index_users_on_confirmation_token", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
