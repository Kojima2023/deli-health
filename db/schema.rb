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

ActiveRecord::Schema.define(version: 2023_01_27_151153) do

  create_table "likes", force: :cascade do |t|
    t.integer "tomorecipe_id", null: false
    t.integer "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["tomorecipe_id"], name: "index_likes_on_tomorecipe_id"
    t.index ["user_id"], name: "index_likes_on_user_id"
  end

  create_table "tag_maps", force: :cascade do |t|
    t.integer "tomorecipe_id", null: false
    t.integer "tag_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["tag_id"], name: "index_tag_maps_on_tag_id"
    t.index ["tomorecipe_id"], name: "index_tag_maps_on_tomorecipe_id"
  end

  create_table "tags", force: :cascade do |t|
    t.string "tag_name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "tomorecipes", force: :cascade do |t|
    t.string "title"
    t.text "ingredient"
    t.text "recipe"
    t.text "point"
    t.string "cost"
    t.string "time"
    t.integer "user_id"
    t.string "image"
    t.string "image2"
    t.string "image3"
    t.string "image4"
    t.string "video"
    t.string "category"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "name"
    t.text "profile"
    t.string "user_url"
    t.string "image"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "likes", "tomorecipes"
  add_foreign_key "likes", "users"
  add_foreign_key "tag_maps", "tags"
  add_foreign_key "tag_maps", "tomorecipes"
end
