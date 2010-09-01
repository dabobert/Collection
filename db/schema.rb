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

ActiveRecord::Schema.define(:version => 20100808212220) do

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
    t.integer  "key_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "item_keys", ["item_id"], :name => "index_item_keys_on_item_id"
  add_index "item_keys", ["key_id"], :name => "index_item_keys_on_key_id"

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
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "items", ["item_type_id"], :name => "index_items_on_item_type_id"
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

end
