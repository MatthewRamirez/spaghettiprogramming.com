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

ActiveRecord::Schema.define(version: 20140603214910) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "blog_attachments", force: :cascade do |t|
    t.integer  "blog_post_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.datetime "file_updated_at"
  end

  add_index "blog_attachments", ["blog_post_id"], name: "index_blog_attachments_on_blog_post_id", using: :btree

  create_table "blog_images", force: :cascade do |t|
    t.integer  "blog_post_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  add_index "blog_images", ["blog_post_id"], name: "index_blog_images_on_blog_post_id", using: :btree

  create_table "blog_posts", force: :cascade do |t|
    t.text     "title",                              null: false
    t.text     "body",                               null: false
    t.integer  "category_id"
    t.integer  "user_id"
    t.datetime "created_at",       default: "now()"
    t.datetime "updated_at",       default: "now()"
    t.text     "rendered_content"
    t.boolean  "published",        default: true,    null: false
    t.text     "slug"
    t.integer  "created_at_month"
    t.integer  "created_at_year"
  end

  add_index "blog_posts", ["category_id"], name: "index_blog_posts_on_category_id", using: :btree
  add_index "blog_posts", ["created_at_month"], name: "index_blog_posts_on_created_at_month", using: :btree
  add_index "blog_posts", ["created_at_year"], name: "index_blog_posts_on_created_at_year", using: :btree
  add_index "blog_posts", ["published"], name: "index_blog_posts_on_published", using: :btree
  add_index "blog_posts", ["slug"], name: "index_blog_posts_on_slug", using: :btree

  create_table "categories", force: :cascade do |t|
    t.text     "name",                         null: false
    t.datetime "created_at", default: "now()"
    t.datetime "updated_at", default: "now()"
  end

  add_index "categories", ["name"], name: "index_categories_on_name", unique: true, using: :btree

  create_table "sessions", force: :cascade do |t|
    t.string   "session_id", null: false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], name: "index_sessions_on_session_id", using: :btree
  add_index "sessions", ["updated_at"], name: "index_sessions_on_updated_at", using: :btree

  create_table "users", force: :cascade do |t|
    t.text     "email",                             null: false
    t.text     "identifier_url"
    t.text     "nick"
    t.datetime "created_at",      default: "now()"
    t.datetime "updated_at",      default: "now()"
    t.text     "password_digest"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree

end
