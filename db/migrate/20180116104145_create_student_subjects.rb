class CreateStudentSubjects < ActiveRecord::Migration
  def change
    create_table :student_subjects do |t|
      t.references :student, index: true, foreign_key: true
      t.references :subject, index: true, foreign_key: true
      t.timestamps null: false
    end
  end
end