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

ActiveRecord::Schema.define(version: 20140325213347) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "exercises", force: true do |t|
    t.integer  "topic_id",               null: false
    t.string   "name"
    t.text     "duration"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "part",       default: 1, null: false
  end

  add_index "exercises", ["topic_id"], name: "index_exercises_on_topic_id", using: :btree

  create_table "materials", force: true do |t|
    t.string   "name"
    t.text     "original_name"
    t.text     "description"
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "archived"
  end

  create_table "prerequisites", force: true do |t|
    t.integer "topic_id"
    t.integer "prerequisite_topic_id"
  end

  create_table "requisitions", force: true do |t|
    t.integer  "exercise_id"
    t.integer  "material_id"
    t.integer  "quantity",    default: 1
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "subjects", force: true do |t|
    t.string "code",        null: false
    t.string "name",        null: false
    t.text   "description"
  end

  add_index "subjects", ["code"], name: "index_subjects_on_code", unique: true, using: :btree

  create_table "topics", force: true do |t|
    t.integer  "subject_id",               null: false
    t.string   "name",                     null: false
    t.integer  "order",                    null: false
    t.text     "overview"
    t.text     "progression"
    t.text     "objectives"
    t.text     "teachable_moments"
    t.text     "questions"
    t.text     "parents"
    t.text     "connections"
    t.text     "books"
    t.string   "code"
    t.string   "slug"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "materials_text"
    t.text     "required_background_text"
  end

  add_index "topics", ["code"], name: "index_topics_on_code", unique: true, using: :btree
  add_index "topics", ["slug"], name: "index_topics_on_slug", unique: true, using: :btree
  add_index "topics", ["subject_id"], name: "index_topics_on_subject_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "name",                          null: false
    t.string   "email",                         null: false
    t.string   "password_hash",                 null: false
    t.string   "access_token",                  null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "admin",         default: false
  end

  add_index "users", ["admin"], name: "index_users_on_admin", using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree

end
