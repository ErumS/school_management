class CreateClassrooms < ActiveRecord::Migration
  def change
    create_table :classrooms do |t|
      t.string :standard
      t.integer :no_of_students
      t.references :school, index: true, foreign_key: true
      t.timestamps null: false
    end
  end
end