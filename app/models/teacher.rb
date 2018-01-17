class Teacher < ActiveRecord::Base
  belongs_to :school
  belongs_to :classroom
  belongs_to :subject
  has_many :student_teacher, dependent: :destroy
  has_many :students, through: :student_teacher, dependent: :destroy
  validates :name, :subject_name, presence: true
  validates :salary, inclusion: {in: 10000..90000}
end