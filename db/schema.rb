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

ActiveRecord::Schema.define(version: 20141208102143) do

  create_table "blobs", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "camlis", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "contacts", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "encrypted_first_name"
    t.string   "encrypted_last_name"
    t.string   "encrypted_email"
  end

  create_table "contacts_groups", id: false, force: true do |t|
    t.integer "contact_id"
    t.integer "group_id"
  end

  create_table "filetypes", id: false, force: true do |t|
    t.string   "extension"
    t.string   "filetype"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "filetypes", ["extension"], name: "extension_index"

  create_table "groups", force: true do |t|
    t.string   "encrypted_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "settings", force: true do |t|
    t.integer  "thumbnail_size"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "shas", force: true do |t|
    t.text     "content"
    t.text     "filename"
    t.text     "extension"
    t.text     "filetype"
    t.text     "icon"
    t.boolean  "public"
    t.boolean  "private"
    t.text     "thumbnail"
    t.text     "download"
    t.text     "auth"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "permanode"
    t.text     "description"
  end

  add_index "shas", ["permanode"], name: "permanode_index"

end
