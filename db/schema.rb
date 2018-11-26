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

ActiveRecord::Schema.define(version: 2018_11_26_005301) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "blog_attachments", id: :serial, force: :cascade do |t|
    t.integer "blog_post_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "file_file_name", limit: 255
    t.string "file_content_type", limit: 255
    t.integer "file_file_size"
    t.datetime "file_updated_at"
    t.index ["blog_post_id"], name: "index_blog_attachments_on_blog_post_id"
  end

  create_table "blog_images", id: :serial, force: :cascade do |t|
    t.integer "blog_post_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "image_file_name", limit: 255
    t.string "image_content_type", limit: 255
    t.integer "image_file_size"
    t.datetime "image_updated_at"
    t.index ["blog_post_id"], name: "index_blog_images_on_blog_post_id"
  end

  create_table "blog_posts", id: :serial, force: :cascade do |t|
    t.text "title", null: false
    t.text "body", null: false
    t.integer "category_id"
    t.integer "user_id"
    t.datetime "created_at", default: -> { "now()" }, null: false
    t.datetime "updated_at", default: -> { "now()" }, null: false
    t.boolean "published", default: true, null: false
    t.text "slug"
    t.integer "created_at_month"
    t.integer "created_at_year"
    t.index ["category_id"], name: "index_blog_posts_on_category_id"
    t.index ["created_at_month"], name: "index_blog_posts_on_created_at_month"
    t.index ["created_at_year"], name: "index_blog_posts_on_created_at_year"
    t.index ["published"], name: "index_blog_posts_on_published"
    t.index ["slug"], name: "index_blog_posts_on_slug"
  end

  create_table "categories", id: :serial, force: :cascade do |t|
    t.text "name", null: false
    t.datetime "created_at", default: -> { "now()" }, null: false
    t.datetime "updated_at", default: -> { "now()" }, null: false
    t.index ["name"], name: "index_categories_on_name", unique: true
  end

  create_table "sessions", id: :serial, force: :cascade do |t|
    t.string "session_id", limit: 255, null: false
    t.text "data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["session_id"], name: "index_sessions_on_session_id"
    t.index ["updated_at"], name: "index_sessions_on_updated_at"
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.text "email", null: false
    t.text "identifier_url"
    t.text "nick"
    t.datetime "created_at", default: -> { "now()" }, null: false
    t.datetime "updated_at", default: -> { "now()" }, null: false
    t.text "password_digest"
    t.index ["email"], name: "index_users_on_email_address", unique: true
  end

end
