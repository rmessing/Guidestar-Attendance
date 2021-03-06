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

ActiveRecord::Schema.define(version: 20170516171100) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "centers", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.string   "username"
    t.string   "reset_digest"
    t.datetime "reset_sent_at"
    t.boolean  "admin",           default: false
    t.string   "dirfname"
    t.string   "dirlname"
  end

  create_table "children", force: :cascade do |t|
    t.string   "fname"
    t.string   "mname"
    t.string   "lname"
    t.integer  "group_id"
    t.integer  "center_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.datetime "birth_date"
    t.integer  "location_id"
  end

  create_table "families", force: :cascade do |t|
    t.integer  "parent_id"
    t.integer  "child_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "center_id"
  end

  create_table "group_teachers", force: :cascade do |t|
    t.integer  "teacher_id"
    t.integer  "group_id"
    t.integer  "center_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "groups", force: :cascade do |t|
    t.string   "name"
    t.integer  "center_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "location_id"
    t.integer  "teacher_id"
  end

  create_table "handoffs", force: :cascade do |t|
    t.string   "attend"
    t.integer  "child_id"
    t.string   "child_fname"
    t.string   "child_mname"
    t.string   "child_lname"
    t.integer  "center_id"
    t.string   "escort_fname"
    t.string   "escort_lname"
    t.string   "group_name"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.string   "location_name"
  end

  create_table "locations", force: :cascade do |t|
    t.string   "name"
    t.integer  "center_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "parents", force: :cascade do |t|
    t.string   "fname"
    t.string   "lname"
    t.string   "email"
    t.integer  "center_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "username"
    t.string   "password_digest"
  end

  create_table "searches", force: :cascade do |t|
    t.string   "class_name"
    t.string   "child_name"
    t.string   "adult_name"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.string   "location_name"
    t.datetime "date_from"
    t.datetime "date_to"
  end

  create_table "teachers", force: :cascade do |t|
    t.string   "fname"
    t.string   "lname"
    t.string   "email"
    t.string   "username"
    t.string   "password_digest"
    t.integer  "center_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "reset_digest"
    t.datetime "reset_sent_at"
  end

end
