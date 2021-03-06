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

ActiveRecord::Schema.define(:version => 20150505052017) do

  create_table "cities", :force => true do |t|
    t.string   "title"
    t.string   "slug"
    t.string   "meta_title"
    t.text     "meta_keywords"
    t.text     "meta_description"
    t.string   "header"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  create_table "entries", :force => true do |t|
    t.text     "title"
    t.string   "url"
    t.text     "description"
    t.datetime "published_at"
    t.datetime "created_at",                               :null => false
    t.datetime "updated_at",                               :null => false
    t.float    "rating",                  :default => 0.0
    t.integer  "source_id"
    t.integer  "vk_shares_count"
    t.integer  "vk_likes_count"
    t.integer  "vk_comments_count"
    t.datetime "vk_updated_at"
    t.integer  "facebook_shares_count"
    t.integer  "facebook_comments_count"
    t.datetime "facebook_updated_at"
    t.integer  "twitter_shares_count"
    t.datetime "twitter_updated_at"
    t.integer  "facebook_likes_count"
  end

  add_index "entries", ["source_id"], :name => "index_entries_on_source_id"

  create_table "sources", :force => true do |t|
    t.string   "url"
    t.string   "source"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "title"
    t.string   "favicon"
    t.integer  "city_id"
  end

  create_table "suggested_entries", :force => true do |t|
    t.string   "url"
    t.text     "title"
    t.string   "entry_type"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "favicon"
  end

end
