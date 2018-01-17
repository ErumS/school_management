class CreateTeachers < ActiveRecord::Migration
  def change
    create_table :teachers do |t|
      t.string :name
      t.string :subject_name
      t.bigint :salary
      t.references :school, index: true, foreign_key: true
      t.references :classroom, index: true, foreign_key: true
      t.references :subject, index: true, foreign_key: true
      t.timestamps null: false
    end
  end
end