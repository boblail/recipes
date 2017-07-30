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

ActiveRecord::Schema.define(version: 20170730195242) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "ratings", force: true do |t|
    t.integer  "recipe_id"
    t.integer  "user_id"
    t.string   "name",       null: false
    t.integer  "value",      null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ratings", ["recipe_id", "user_id"], name: "index_ratings_on_recipe_id_and_user_id", using: :btree

  create_table "recipes", force: true do |t|
    t.string   "name",                       null: false
    t.text     "ingredients",                null: false
    t.text     "instructions",               null: false
    t.string   "tags",          default: [],              array: true
    t.integer  "effort"
    t.integer  "cost"
    t.integer  "healthiness"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "created_by_id",              null: false
    t.tsvector "search_vector"
  end

  add_index "recipes", ["search_vector"], name: "index_recipes_on_search_vector", using: :gin
  add_index "recipes", ["tags"], name: "index_recipes_on_tags", using: :gin

  create_table "users", force: true do |t|
    t.string   "email",              default: "", null: false
    t.integer  "sign_in_count",      default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name",                            null: false
    t.string   "family_members",     default: [],              array: true
    t.string   "image_url"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree

end
