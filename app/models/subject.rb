class Subject < ActiveRecord::Base
  belongs_to :school
  has_many :student_subject, dependent: :destroy
  has_many :students, through: :student_subject, dependent: :destroy
  has_many :teachers, dependent: :destroy
  validates :name, :subject_duration, presence: true
  validates :subject_duration, inclusion: {in: 1..8}
end