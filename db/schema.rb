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

ActiveRecord::Schema.define(version: 20130522105514) do

  create_table "likes", force: true do |t|
    t.integer  "user_id"
    t.integer  "photo_id"
    t.datetime "liked_at"
  end

  add_index "likes", ["user_id", "photo_id"], name: "index_likes_on_user_id_and_photo_id"

  create_table "photos", force: true do |t|
    t.text     "comment"
    t.string   "image"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "slug"
    t.integer  "owner_id"
  end

  add_index "photos", ["owner_id"], name: "index_photos_on_owner_id"
  add_index "photos", ["slug"], name: "index_photos_on_slug"

  create_table "taggings", force: true do |t|
    t.integer  "photo_id"
    t.integer  "tag_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "taggings", ["photo_id", "tag_id"], name: "index_taggings_on_photo_id_and_tag_id"

  create_table "tags", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "provider"
    t.string   "uid"
    t.string   "name"
    t.string   "nickname"
    t.string   "email"
    t.string   "avatar"
    t.string   "token"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "photos_count", default: 0
  end

  add_index "users", ["provider", "uid", "nickname"], name: "index_users_on_provider_and_uid_and_nickname"

end
