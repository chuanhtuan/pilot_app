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

ActiveRecord::Schema.define(version: 20131003092546) do

  create_table "contacts", force: true do |t|
    t.integer  "contact_id"
    t.integer  "contacted_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "contacts", ["contact_id", "contacted_id"], name: "index_contacts_on_contact_id_and_contacted_id", unique: true, using: :btree
  add_index "contacts", ["contact_id"], name: "index_contacts_on_contact_id", using: :btree
  add_index "contacts", ["contacted_id"], name: "index_contacts_on_contacted_id", using: :btree

  create_table "histories", force: true do |t|
    t.string   "content"
    t.integer  "poster_id"
    t.integer  "receiver_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "histories", ["created_at"], name: "index_histories_on_created_at", using: :btree

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.string   "remember_token"
    t.boolean  "admin"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", using: :btree
  add_index "users", ["remember_token"], name: "index_users_on_remember_token", using: :btree

end
