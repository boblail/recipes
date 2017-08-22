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

ActiveRecord::Schema.define(version: 20170819185553) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"

  create_table "cookbooks", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "current_menu_plan_id"
  end

  create_table "menu_plans", force: :cascade do |t|
    t.bigint "cookbook_id", null: false
    t.string "name", null: false
    t.index ["cookbook_id"], name: "index_menu_plans_on_cookbook_id"
  end

  create_table "menu_plans_recipes", id: false, force: :cascade do |t|
    t.bigint "menu_plan_id", null: false
    t.bigint "recipe_id", null: false
    t.index ["menu_plan_id", "recipe_id"], name: "index_menu_plans_recipes_on_menu_plan_id_and_recipe_id", unique: true
  end

  create_table "photos", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.string "filename", limit: 255, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "preparations", force: :cascade do |t|
    t.bigint "recipe_id", null: false
    t.bigint "prepared_by_id", null: false
    t.date "prepared_on", null: false
    t.text "comments", default: "", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["prepared_by_id"], name: "index_preparations_on_prepared_by_id"
    t.index ["recipe_id"], name: "index_preparations_on_recipe_id"
  end

  create_table "ratings", id: :serial, force: :cascade do |t|
    t.integer "recipe_id"
    t.integer "user_id"
    t.string "name", limit: 255, null: false
    t.integer "value", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["recipe_id", "user_id"], name: "index_ratings_on_recipe_id_and_user_id"
  end

  create_table "recipes", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255, null: false
    t.text "ingredients", null: false
    t.text "instructions", null: false
    t.string "tags", limit: 255, default: [], array: true
    t.integer "effort"
    t.integer "cost"
    t.integer "healthiness"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "created_by_id", null: false
    t.tsvector "search_vector"
    t.integer "cookbook_id", null: false
    t.string "source", limit: 255
    t.string "servings", limit: 255, default: "", null: false
    t.uuid "photo_id"
    t.bigint "copy_of_id"
    t.boolean "new_recipe", default: true, null: false
    t.date "last_prepared_on"
    t.index ["cookbook_id"], name: "index_recipes_on_cookbook_id"
    t.index ["copy_of_id"], name: "index_recipes_on_copy_of_id"
    t.index ["search_vector"], name: "index_recipes_on_search_vector", using: :gin
    t.index ["tags"], name: "index_recipes_on_tags", using: :gin
  end

  create_table "recipes_tags", id: false, force: :cascade do |t|
    t.bigint "recipe_id", null: false
    t.bigint "tag_id", null: false
    t.index ["recipe_id", "tag_id"], name: "index_recipes_tags_on_recipe_id_and_tag_id", unique: true
  end

  create_table "tags", force: :cascade do |t|
    t.bigint "cookbook_id", null: false
    t.string "name", null: false
    t.index ["cookbook_id", "name"], name: "index_tags_on_cookbook_id_and_name", unique: true
    t.index ["cookbook_id"], name: "index_tags_on_cookbook_id"
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string "email", limit: 255, default: "", null: false
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip", limit: 255
    t.string "last_sign_in_ip", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "first_name", limit: 255, null: false
    t.string "image_url", limit: 255
    t.string "last_name", limit: 255
    t.integer "cookbook_id", null: false
    t.index ["cookbook_id"], name: "index_users_on_cookbook_id"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "cookbooks", "menu_plans", column: "current_menu_plan_id"
  add_foreign_key "menu_plans", "cookbooks", on_delete: :cascade
  add_foreign_key "preparations", "recipes", on_delete: :cascade
  add_foreign_key "preparations", "users", column: "prepared_by_id"
  add_foreign_key "recipes", "recipes", column: "copy_of_id", on_delete: :nullify
  add_foreign_key "tags", "cookbooks", on_delete: :cascade
end
