class Classroom < ActiveRecord::Base
  belongs_to :school
  has_many :students, dependent: :destroy
  has_many :teachers, dependent: :destroy
  validates :standard, presence: true
  validates :no_of_students, presence: true, inclusion: {in: 10..60}
end