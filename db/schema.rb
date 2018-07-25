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

ActiveRecord::Schema.define(version: 2018_07_05_050822) do

  create_table "address_masters", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "empid"
    t.date "create_date"
    t.string "name"
    t.string "address"
    t.string "landmark"
    t.string "phone_no"
    t.string "website"
    t.string "pincode"
  end

  create_table "career_applieds", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "phone_no"
    t.string "resume_link"
    t.integer "applied_for"
    t.date "applied_date"
    t.integer "profile_status", default: 0, null: false
  end

  create_table "careers", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.text "skills"
    t.date "created_at"
  end

  create_table "category_masters", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "parent_id", default: 0, null: false
    t.string "cat_name"
  end

  create_table "contacts", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "phone"
    t.text "message"
    t.integer "status", default: 0, null: false
    t.date "contact_date"
  end

  create_table "country_masters", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "country_name"
    t.string "population"
    t.string "area_size"
    t.string "pupulation_size"
  end

  create_table "department_masters", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
  end

  create_table "district_masters", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "country_id"
    t.integer "state_id"
    t.string "district_name"
  end

  create_table "emp_daywises", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "empid"
    t.date "date"
    t.string "max_hour"
    t.integer "line_count", default: 0, null: false
    t.string "page_count", default: "0", null: false
  end

  create_table "emp_filepaths", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "empid"
    t.integer "logid"
    t.string "file_path"
    t.string "file_name"
    t.date "create_date"
  end

  create_table "emp_loginwises", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "empid"
    t.date "date"
    t.time "intime"
    t.time "outtime"
  end

  create_table "emp_monthwises", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "empid"
    t.date "month"
    t.integer "line_count", default: 0, null: false
    t.string "page_count", default: "0", null: false
  end

  create_table "emp_worksheet_counts", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "empid"
    t.integer "fileid"
    t.integer "catid"
    t.integer "logid", default: 0, null: false
    t.integer "line_count", default: 0, null: false
    t.integer "page_count", default: 0, null: false
    t.date "create_at"
  end

  create_table "employee_profiles", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "userid", default: 0, null: false
    t.string "door_no"
    t.string "street"
    t.string "village"
    t.string "city"
    t.string "pincode"
    t.integer "qualification"
    t.integer "experience"
    t.integer "department"
    t.string "phone_no"
    t.date "birth_date"
    t.string "bank_acc_no"
    t.string "bank_ifsc"
  end

  create_table "login_masters", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "empid"
    t.string "ip_address", limit: 15
    t.date "log_date"
    t.time "login_time"
    t.time "logout_time"
  end

  create_table "pincode_masters", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "country_id"
    t.integer "state_id"
    t.integer "district_id"
    t.integer "taluk_id"
    t.string "pincode"
  end

  create_table "qualification_masters", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
  end

  create_table "state_masters", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "country_id"
    t.string "state_name"
  end

  create_table "taluk_masters", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "country_id"
    t.integer "state_id"
    t.integer "district_id"
    t.string "taluk_name"
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.integer "empid", default: 0, null: false
    t.integer "role", default: 0, null: false
    t.integer "deactive", default: 0, null: false
    t.string "password_digest"
    t.integer "current_status", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "village_masters", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "country_id"
    t.integer "state_id"
    t.integer "district_id"
    t.integer "taluk_id"
    t.integer "pincode_id"
    t.string "village_name"
  end

end
