class Student < ActiveRecord::Base
  belongs_to :school
  belongs_to :classroom
  has_many :student_subject, dependent: :destroy
  has_many :student_teacher, dependent: :destroy
  has_many :subjects, through: :student_subject, dependent: :destroy
  has_many :teachers, through: :student_teacher, dependent: :destroy
  validates :name, :address, :phone_no, presence: true
  validates :phone_no, length: {in: 8..15}
end