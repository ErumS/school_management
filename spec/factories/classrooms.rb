FactoryGirl.define do
  factory :classroom do
    standard Faker::Number.between(1, 12)
    no_of_students Faker::Number.between(10, 60)
  end
end