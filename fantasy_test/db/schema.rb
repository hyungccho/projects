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

ActiveRecord::Schema.define(version: 20150926235310) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "drafts", force: :cascade do |t|
    t.integer  "league_id",                  null: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.boolean  "finished",   default: false
    t.string   "drafters",   default: [],                 array: true
  end

  add_index "drafts", ["league_id"], name: "index_drafts_on_league_id", using: :btree

  create_table "league_memberships", force: :cascade do |t|
    t.integer  "player_id",  null: false
    t.integer  "league_id",  null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "user_id"
  end

  add_index "league_memberships", ["player_id", "league_id"], name: "index_league_memberships_on_player_id_and_league_id", unique: true, using: :btree
  add_index "league_memberships", ["user_id"], name: "index_league_memberships_on_user_id", using: :btree

  create_table "leagues", force: :cascade do |t|
    t.string   "name",                         null: false
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.boolean  "status",       default: false
    t.boolean  "started",      default: false
    t.integer  "moderator_id"
  end

  add_index "leagues", ["moderator_id"], name: "index_leagues_on_moderator_id", using: :btree
  add_index "leagues", ["name"], name: "index_leagues_on_name", unique: true, using: :btree

  create_table "players", primary_key: "player_id", force: :cascade do |t|
    t.integer  "active",     null: false
    t.integer  "jersey",     null: false
    t.string   "lname",      null: false
    t.string   "fname",      null: false
    t.string   "team",       null: false
    t.string   "position",   null: false
    t.string   "dob",        null: false
    t.string   "height"
    t.string   "weight"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "players", ["active"], name: "index_players_on_active", using: :btree
  add_index "players", ["position"], name: "index_players_on_position", using: :btree
  add_index "players", ["team"], name: "index_players_on_team", using: :btree

  create_table "rankings", force: :cascade do |t|
    t.integer  "week_id",    null: false
    t.integer  "player_id",  null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float    "points"
  end

  add_index "rankings", ["player_id"], name: "index_rankings_on_player_id", using: :btree
  add_index "rankings", ["week_id"], name: "index_rankings_on_week_id", using: :btree

  create_table "teams", force: :cascade do |t|
    t.string   "code",       null: false
    t.string   "full_name",  null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "teams", ["code"], name: "index_teams_on_code", unique: true, using: :btree

  create_table "user_memberships", force: :cascade do |t|
    t.integer  "user_id",    null: false
    t.integer  "league_id",  null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "user_memberships", ["user_id", "league_id"], name: "index_user_memberships_on_user_id_and_league_id", unique: true, using: :btree

  create_table "user_teams", force: :cascade do |t|
    t.integer  "league_id",              null: false
    t.integer  "wins",       default: 0, null: false
    t.integer  "losses",     default: 0, null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "user_teams", ["league_id"], name: "index_user_teams_on_league_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "username"
    t.string   "password_digest"
    t.string   "session_token"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "users", ["session_token"], name: "index_users_on_session_token", using: :btree

  create_table "weeks", force: :cascade do |t|
    t.string   "position",   null: false
    t.integer  "week_num",   null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "weeks", ["position"], name: "index_weeks_on_position", using: :btree
  add_index "weeks", ["week_num"], name: "index_weeks_on_week_num", using: :btree

end
