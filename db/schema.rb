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

ActiveRecord::Schema[8.0].define(version: 2025_08_14_175552) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "academic_periods", force: :cascade do |t|
    t.bigint "faculty_id", null: false
    t.string "name"
    t.date "start_date"
    t.date "end_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["faculty_id"], name: "index_academic_periods_on_faculty_id"
  end

  create_table "added_schedules", force: :cascade do |t|
    t.bigint "schedule_id", null: false
    t.bigint "classroom_id"
    t.bigint "teacher_id"
    t.date "date", null: false
    t.time "time"
    t.bigint "student_group_id", null: false
    t.integer "course", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["classroom_id"], name: "index_added_schedules_on_classroom_id"
    t.index ["schedule_id"], name: "index_added_schedules_on_schedule_id"
    t.index ["student_group_id"], name: "index_added_schedules_on_student_group_id"
    t.index ["teacher_id"], name: "index_added_schedules_on_teacher_id"
  end

  create_table "classrooms", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "deleted_schedules", force: :cascade do |t|
    t.bigint "schedule_id", null: false
    t.date "date"
    t.bigint "student_group_id", null: false
    t.integer "course"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["schedule_id"], name: "index_deleted_schedules_on_schedule_id"
    t.index ["student_group_id"], name: "index_deleted_schedules_on_student_group_id"
  end

  create_table "faculties", force: :cascade do |t|
    t.string "full_name"
    t.string "short_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "lessons", force: :cascade do |t|
    t.integer "lesson_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "schedule_changes", force: :cascade do |t|
    t.bigint "schedule_id", null: false
    t.bigint "special_schedule_id", null: false
    t.bigint "academic_period_id", null: false
    t.bigint "student_group_id", null: false
    t.bigint "subject_id", null: false
    t.bigint "teacher_id", null: false
    t.bigint "classroom_id", null: false
    t.integer "day_of_week"
    t.time "start_time"
    t.bigint "lesson_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["academic_period_id"], name: "index_schedule_changes_on_academic_period_id"
    t.index ["classroom_id"], name: "index_schedule_changes_on_classroom_id"
    t.index ["lesson_id"], name: "index_schedule_changes_on_lesson_id"
    t.index ["schedule_id"], name: "index_schedule_changes_on_schedule_id"
    t.index ["special_schedule_id"], name: "index_schedule_changes_on_special_schedule_id"
    t.index ["student_group_id"], name: "index_schedule_changes_on_student_group_id"
    t.index ["subject_id"], name: "index_schedule_changes_on_subject_id"
    t.index ["teacher_id"], name: "index_schedule_changes_on_teacher_id"
  end

  create_table "schedules", force: :cascade do |t|
    t.bigint "academic_period_id", null: false
    t.bigint "student_group_id", null: false
    t.bigint "subject_id", null: false
    t.bigint "teacher_id", null: false
    t.bigint "classroom_id", null: false
    t.integer "day_of_week"
    t.boolean "under"
    t.time "start_time"
    t.bigint "lesson_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "course"
    t.index ["academic_period_id"], name: "index_schedules_on_academic_period_id"
    t.index ["classroom_id"], name: "index_schedules_on_classroom_id"
    t.index ["lesson_id"], name: "index_schedules_on_lesson_id"
    t.index ["student_group_id"], name: "index_schedules_on_student_group_id"
    t.index ["subject_id"], name: "index_schedules_on_subject_id"
    t.index ["teacher_id"], name: "index_schedules_on_teacher_id"
  end

  create_table "special_periods", force: :cascade do |t|
    t.bigint "academic_period_id", null: false
    t.string "name"
    t.date "start_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "student_group_id", null: false
    t.integer "course"
    t.index ["academic_period_id"], name: "index_special_periods_on_academic_period_id"
    t.index ["student_group_id"], name: "index_special_periods_on_student_group_id"
  end

  create_table "special_schedules", force: :cascade do |t|
    t.bigint "special_period_id", null: false
    t.bigint "teacher_id", null: false
    t.bigint "subject_id", null: false
    t.bigint "classroom_id", null: false
    t.time "start_time"
    t.bigint "lesson_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "student_group_id", null: false
    t.integer "course"
    t.index ["classroom_id"], name: "index_special_schedules_on_classroom_id"
    t.index ["lesson_id"], name: "index_special_schedules_on_lesson_id"
    t.index ["special_period_id"], name: "index_special_schedules_on_special_period_id"
    t.index ["student_group_id"], name: "index_special_schedules_on_student_group_id"
    t.index ["subject_id"], name: "index_special_schedules_on_subject_id"
    t.index ["teacher_id"], name: "index_special_schedules_on_teacher_id"
  end

  create_table "student_groups", force: :cascade do |t|
    t.string "group_name"
    t.bigint "faculty_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["faculty_id"], name: "index_student_groups_on_faculty_id"
  end

  create_table "subjects", force: :cascade do |t|
    t.string "name"
    t.boolean "is_exam"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "teachers", force: :cascade do |t|
    t.string "name"
    t.string "surname"
    t.string "patronymic"
    t.string "post"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index "to_tsvector('russian'::regconfig, (((((surname)::text || ' '::text) || (name)::text) || ' '::text) || (patronymic)::text))", name: "index_teachers_on_full_name", using: :gin
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.boolean "admin", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "academic_periods", "faculties"
  add_foreign_key "added_schedules", "classrooms"
  add_foreign_key "added_schedules", "schedules"
  add_foreign_key "added_schedules", "student_groups"
  add_foreign_key "added_schedules", "teachers"
  add_foreign_key "deleted_schedules", "schedules"
  add_foreign_key "deleted_schedules", "student_groups"
  add_foreign_key "schedule_changes", "academic_periods"
  add_foreign_key "schedule_changes", "classrooms"
  add_foreign_key "schedule_changes", "lessons"
  add_foreign_key "schedule_changes", "schedules"
  add_foreign_key "schedule_changes", "special_schedules"
  add_foreign_key "schedule_changes", "student_groups"
  add_foreign_key "schedule_changes", "subjects"
  add_foreign_key "schedule_changes", "teachers"
  add_foreign_key "schedules", "academic_periods"
  add_foreign_key "schedules", "classrooms"
  add_foreign_key "schedules", "lessons"
  add_foreign_key "schedules", "student_groups"
  add_foreign_key "schedules", "subjects"
  add_foreign_key "schedules", "teachers"
  add_foreign_key "special_periods", "academic_periods"
  add_foreign_key "special_periods", "student_groups"
  add_foreign_key "special_schedules", "classrooms"
  add_foreign_key "special_schedules", "lessons"
  add_foreign_key "special_schedules", "special_periods"
  add_foreign_key "special_schedules", "student_groups"
  add_foreign_key "special_schedules", "subjects"
  add_foreign_key "special_schedules", "teachers"
  add_foreign_key "student_groups", "faculties"
end
