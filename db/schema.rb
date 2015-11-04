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

ActiveRecord::Schema.define(version: 20151027025057) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "comments", force: true do |t|
    t.integer  "request_id"
    t.integer  "user_id"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "firstname"
  end

  add_index "comments", ["request_id"], name: "index_comments_on_request_id", using: :btree
  add_index "comments", ["user_id"], name: "index_comments_on_user_id", using: :btree

  create_table "likes", force: true do |t|
    t.integer  "user_id"
    t.integer  "request_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "likes", ["request_id"], name: "index_likes_on_request_id", using: :btree
  add_index "likes", ["user_id"], name: "index_likes_on_user_id", using: :btree

  create_table "prayers", force: true do |t|
    t.integer  "user_id"
    t.integer  "request_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "pr_count"
  end

  add_index "prayers", ["request_id"], name: "index_prayers_on_request_id", using: :btree
  add_index "prayers", ["user_id"], name: "index_prayers_on_user_id", using: :btree

  create_table "requests", force: true do |t|
    t.text     "content"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "result"
    t.boolean  "firstname"
    t.text     "request"
    t.string   "topic"
    t.string   "visible"
  end

  add_index "requests", ["user_id"], name: "index_requests_on_user_id", using: :btree

  create_table "subscriptions", force: true do |t|
    t.integer  "user_id"
    t.integer  "request_id"
    t.boolean  "daily"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "week_count"
  end

  add_index "subscriptions", ["request_id"], name: "index_subscriptions_on_request_id", using: :btree
  add_index "subscriptions", ["user_id"], name: "index_subscriptions_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "username"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "church"
    t.string   "city"
    t.string   "state"
    t.integer  "zipcode"
    t.string   "church_campus"
    t.string   "fellowship"
    t.integer  "subs_frq"
    t.boolean  "email_subs"
    t.boolean  "email_prays"
    t.boolean  "email_comms"
    t.string   "auth_token"
    t.string   "password_reset_token"
    t.datetime "password_reset_sent_at"
  end

end
