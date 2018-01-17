class School < ActiveRecord::Base
  has_many :classrooms, dependent: :destroy
  has_many :students, dependent: :destroy
  has_many :subjects, dependent: :destroy
  has_many :teachers, dependent: :destroy
  validates :name, presence: true
  validates :address, presence: true
  validates :phone_no, presence: true, length: {in: 8..15}
end