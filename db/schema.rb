# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2024_04_18_200906) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "calendar_groups", force: :cascade do |t|
    t.bigint "admin_id", null: false
    t.bigint "calendar_horse_id"
    t.bigint "calendar_pony_id"
    t.string "group_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "parallel_reservation", default: false
    t.index ["admin_id"], name: "index_calendar_groups_on_admin_id"
    t.index ["calendar_horse_id"], name: "index_calendar_groups_on_calendar_horse_id"
    t.index ["calendar_pony_id"], name: "index_calendar_groups_on_calendar_pony_id"
  end

  create_table "calendar_horses", force: :cascade do |t|
    t.string "horse_name"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "calendar_group_id", null: false
    t.index ["calendar_group_id"], name: "index_calendar_horses_on_calendar_group_id"
  end

  create_table "calendar_horses_participant_reservations", id: false, force: :cascade do |t|
    t.bigint "participant_reservation_id", null: false
    t.bigint "calendar_horse_id", null: false
    t.index ["calendar_horse_id", "participant_reservation_id"], name: "idx_on_calendar_horse_id_participant_reservation_id_a1985287be"
    t.index ["participant_reservation_id", "calendar_horse_id"], name: "idx_on_participant_reservation_id_calendar_horse_id_00bf37d185"
  end

  create_table "calendar_participant_join_tables", force: :cascade do |t|
    t.bigint "calendar_group_id"
    t.bigint "user_id"
    t.index ["calendar_group_id"], name: "index_calendar_participant_join_tables_on_calendar_group_id"
    t.index ["user_id"], name: "index_calendar_participant_join_tables_on_user_id"
  end

  create_table "calendar_participants", force: :cascade do |t|
    t.bigint "calendar_participant_join_table_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "participant_reservation_id"
    t.index ["calendar_participant_join_table_id"], name: "idx_on_calendar_participant_join_table_id_f6ee481875"
    t.index ["participant_reservation_id"], name: "index_calendar_participants_on_participant_reservation_id"
  end

  create_table "calendar_ponies", force: :cascade do |t|
    t.string "pony_name"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "calendar_group_id", null: false
    t.index ["calendar_group_id"], name: "index_calendar_ponies_on_calendar_group_id"
  end

  create_table "calendar_ponies_participant_reservations", id: false, force: :cascade do |t|
    t.bigint "participant_reservation_id", null: false
    t.bigint "calendar_pony_id", null: false
    t.index ["calendar_pony_id", "participant_reservation_id"], name: "idx_on_calendar_pony_id_participant_reservation_id_96526e65f9"
    t.index ["participant_reservation_id", "calendar_pony_id"], name: "idx_on_participant_reservation_id_calendar_pony_id_a445630158"
  end

  create_table "exercises", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "exercise_name"
    t.text "exercise_description"
    t.string "animal_type"
    t.string "exercise_type"
    t.boolean "public"
    t.boolean "completed"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "canvas_data"
    t.binary "canvas_image"
    t.index ["user_id"], name: "index_exercises_on_user_id"
  end

  create_table "horse_courses", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "exercise_id"
    t.binary "canvas_image"
    t.index ["exercise_id"], name: "index_horse_courses_on_exercise_id"
  end

  create_table "horse_courses_users", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "horse_course_id", null: false
    t.boolean "used", default: false
    t.boolean "saved", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["horse_course_id"], name: "index_horse_courses_users_on_horse_course_id"
    t.index ["user_id"], name: "index_horse_courses_users_on_user_id"
  end

  create_table "horse_exercises", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "exercise_id"
    t.binary "canvas_image"
    t.index ["exercise_id"], name: "index_horse_exercises_on_exercise_id"
  end

  create_table "horse_exercises_users", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "horse_exercise_id", null: false
    t.boolean "used", default: false
    t.boolean "saved", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["horse_exercise_id"], name: "index_horse_exercises_users_on_horse_exercise_id"
    t.index ["user_id"], name: "index_horse_exercises_users_on_user_id"
  end

  create_table "participant_reservations", force: :cascade do |t|
    t.bigint "calendar_pony_id"
    t.bigint "calendar_horse_id"
    t.date "date"
    t.time "time_from"
    t.time "time_to"
    t.text "comments"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "calendar_group_id", null: false
    t.bigint "calendar_participant_join_table_id", null: false
    t.bigint "created_by_id"
    t.index ["calendar_group_id"], name: "index_participant_reservations_on_calendar_group_id"
    t.index ["calendar_horse_id"], name: "index_participant_reservations_on_calendar_horse_id"
    t.index ["calendar_participant_join_table_id"], name: "idx_on_calendar_participant_join_table_id_2efaace85b"
    t.index ["calendar_pony_id"], name: "index_participant_reservations_on_calendar_pony_id"
  end

  create_table "pending_associations", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "calendar_group_id"
    t.string "status", default: "pending"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["calendar_group_id"], name: "index_pending_associations_on_calendar_group_id"
    t.index ["user_id"], name: "index_pending_associations_on_user_id"
  end

  create_table "pony_courses", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "exercise_id"
    t.binary "canvas_image"
    t.index ["exercise_id"], name: "index_pony_courses_on_exercise_id"
  end

  create_table "pony_courses_users", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "pony_course_id", null: false
    t.boolean "used", default: false
    t.boolean "saved", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["pony_course_id"], name: "index_pony_courses_users_on_pony_course_id"
    t.index ["user_id"], name: "index_pony_courses_users_on_user_id"
  end

  create_table "pony_exercises", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "exercise_id"
    t.binary "canvas_image"
    t.index ["exercise_id"], name: "index_pony_exercises_on_exercise_id"
  end

  create_table "pony_exercises_users", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "pony_exercise_id", null: false
    t.boolean "used", default: false
    t.boolean "saved", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["pony_exercise_id"], name: "index_pony_exercises_users_on_pony_exercise_id"
    t.index ["user_id"], name: "index_pony_exercises_users_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "surname"
    t.string "username"
    t.string "email"
    t.string "password_digest"
    t.binary "avatar"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "calendar_groups", "calendar_horses"
  add_foreign_key "calendar_groups", "calendar_ponies"
  add_foreign_key "calendar_groups", "users", column: "admin_id"
  add_foreign_key "calendar_horses", "calendar_groups"
  add_foreign_key "calendar_participant_join_tables", "calendar_groups"
  add_foreign_key "calendar_participant_join_tables", "users"
  add_foreign_key "calendar_participants", "calendar_participant_join_tables"
  add_foreign_key "calendar_ponies", "calendar_groups"
  add_foreign_key "exercises", "users"
  add_foreign_key "horse_courses", "exercises"
  add_foreign_key "horse_courses_users", "horse_courses"
  add_foreign_key "horse_courses_users", "users"
  add_foreign_key "horse_exercises", "exercises"
  add_foreign_key "horse_exercises_users", "horse_exercises"
  add_foreign_key "horse_exercises_users", "users"
  add_foreign_key "participant_reservations", "calendar_groups"
  add_foreign_key "participant_reservations", "calendar_horses"
  add_foreign_key "participant_reservations", "calendar_participant_join_tables", on_delete: :cascade
  add_foreign_key "participant_reservations", "calendar_ponies"
  add_foreign_key "pending_associations", "calendar_groups"
  add_foreign_key "pending_associations", "users"
  add_foreign_key "pony_courses", "exercises"
  add_foreign_key "pony_courses_users", "pony_courses"
  add_foreign_key "pony_courses_users", "users"
  add_foreign_key "pony_exercises", "exercises"
  add_foreign_key "pony_exercises_users", "pony_exercises"
  add_foreign_key "pony_exercises_users", "users"
end
