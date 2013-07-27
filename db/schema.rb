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

ActiveRecord::Schema.define(:version => 20130726191238) do

  create_table "blog_attachments", :force => true do |t|
    t.integer  "blog_post_id"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.datetime "file_updated_at"
  end

  add_index "blog_attachments", ["blog_post_id"], :name => "index_blog_attachments_on_blog_post_id"

  create_table "blog_images", :force => true do |t|
    t.integer  "blog_post_id"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  add_index "blog_images", ["blog_post_id"], :name => "index_blog_images_on_blog_post_id"

  create_table "blog_posts", :force => true do |t|
    t.text     "title",                              :null => false
    t.text     "body",                               :null => false
    t.integer  "category_id"
    t.integer  "user_id"
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
    t.text     "rendered_content"
    t.boolean  "published",        :default => true, :null => false
    t.text     "slug"
  end

  add_index "blog_posts", ["category_id"], :name => "index_blog_posts_on_category_id"
  add_index "blog_posts", ["published"], :name => "index_blog_posts_on_published"
  add_index "blog_posts", ["slug"], :name => "index_blog_posts_on_slug"

  create_table "categories", :force => true do |t|
    t.text     "name",       :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "categories", ["name"], :name => "index_categories_on_name", :unique => true

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "users", :force => true do |t|
    t.text     "email",           :null => false
    t.text     "identifier_url"
    t.text     "nick"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.text     "password_digest"
  end

  add_index "users", ["email"], :name => "index_users_on_email_address", :unique => true

end
