ActiveRecord::Schema.define(version: 20180116104151) do

  create_table "classrooms", force: :cascade do |t|
    t.string   "standard",       limit: 255
    t.integer  "no_of_students", limit: 4
    t.integer  "school_id",      limit: 4
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "classrooms", ["school_id"], name: "index_classrooms_on_school_id", using: :btree

  create_table "schools", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.text     "address",    limit: 65535
    t.string   "phone_no",   limit: 255
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "student_subjects", force: :cascade do |t|
    t.integer  "student_id", limit: 4
    t.integer  "subject_id", limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "student_subjects", ["student_id"], name: "index_student_subjects_on_student_id", using: :btree
  add_index "student_subjects", ["subject_id"], name: "index_student_subjects_on_subject_id", using: :btree

  create_table "student_teachers", force: :cascade do |t|
    t.integer  "student_id", limit: 4
    t.integer  "teacher_id", limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "student_teachers", ["student_id"], name: "index_student_teachers_on_student_id", using: :btree
  add_index "student_teachers", ["teacher_id"], name: "index_student_teachers_on_teacher_id", using: :btree

  create_table "students", force: :cascade do |t|
    t.string   "name",         limit: 255
    t.string   "address",      limit: 255
    t.string   "phone_no",     limit: 255
    t.decimal  "percentage",               precision: 10
    t.integer  "school_id",    limit: 4
    t.integer  "classroom_id", limit: 4
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
  end

  add_index "students", ["classroom_id"], name: "index_students_on_classroom_id", using: :btree
  add_index "students", ["school_id"], name: "index_students_on_school_id", using: :btree

  create_table "subjects", force: :cascade do |t|
    t.string   "name",             limit: 255
    t.integer  "subject_duration", limit: 4
    t.integer  "school_id",        limit: 4
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  add_index "subjects", ["school_id"], name: "index_subjects_on_school_id", using: :btree

  create_table "teachers", force: :cascade do |t|
    t.string   "name",         limit: 255
    t.string   "subject_name", limit: 255
    t.integer  "salary",       limit: 8
    t.integer  "school_id",    limit: 4
    t.integer  "classroom_id", limit: 4
    t.integer  "subject_id",   limit: 4
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "teachers", ["classroom_id"], name: "index_teachers_on_classroom_id", using: :btree
  add_index "teachers", ["school_id"], name: "index_teachers_on_school_id", using: :btree
  add_index "teachers", ["subject_id"], name: "index_teachers_on_subject_id", using: :btree

  add_foreign_key "classrooms", "schools"
  add_foreign_key "student_subjects", "students"
  add_foreign_key "student_subjects", "subjects"
  add_foreign_key "student_teachers", "students"
  add_foreign_key "student_teachers", "teachers"
  add_foreign_key "students", "classrooms"
  add_foreign_key "students", "schools"
  add_foreign_key "subjects", "schools"
  add_foreign_key "teachers", "classrooms"
  add_foreign_key "teachers", "schools"
  add_foreign_key "teachers", "subjects"
end
