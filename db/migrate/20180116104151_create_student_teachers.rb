class CreateStudentTeachers < ActiveRecord::Migration
  def change
    create_table :student_teachers do |t|
      t.references :student, index: true, foreign_key: true
      t.references :teacher, index: true, foreign_key: true
      t.timestamps null: false
    end
  end
end
