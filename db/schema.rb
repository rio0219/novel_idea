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

ActiveRecord::Schema[7.2].define(version: 2025_09_26_144549) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "ai_consultations", force: :cascade do |t|
    t.text "content"
    t.text "response"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_ai_consultations_on_user_id"
  end

  create_table "characters", force: :cascade do |t|
    t.bigint "work_id", null: false
    t.string "name"
    t.integer "age"
    t.string "gender"
    t.string "hair_color"
    t.string "eye_color"
    t.string "physique"
    t.text "others"
    t.text "personality"
    t.text "background"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["work_id"], name: "index_characters_on_work_id"
  end

  create_table "comments", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "post_id", null: false
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["post_id"], name: "index_comments_on_post_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "genres", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "plots", force: :cascade do |t|
    t.bigint "work_id", null: false
    t.string "chapter_title"
    t.text "purpose"
    t.text "event"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["work_id"], name: "index_plots_on_work_id"
  end

  create_table "posts", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "genre_id", null: false
    t.text "content", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["genre_id"], name: "index_posts_on_genre_id"
    t.index ["user_id"], name: "index_posts_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "works", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "genre_id", null: false
    t.string "title"
    t.string "theme"
    t.text "synopsis"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["genre_id"], name: "index_works_on_genre_id"
    t.index ["user_id"], name: "index_works_on_user_id"
  end

  create_table "worldviews", force: :cascade do |t|
    t.bigint "work_id", null: false
    t.string "country"
    t.text "culture"
    t.text "technology"
    t.text "faction"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["work_id"], name: "index_worldviews_on_work_id"
  end

  add_foreign_key "ai_consultations", "users"
  add_foreign_key "characters", "works"
  add_foreign_key "comments", "posts"
  add_foreign_key "comments", "users"
  add_foreign_key "plots", "works"
  add_foreign_key "posts", "genres"
  add_foreign_key "posts", "users"
  add_foreign_key "works", "genres"
  add_foreign_key "works", "users"
  add_foreign_key "worldviews", "works"
end
