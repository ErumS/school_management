FactoryGirl.define do
  factory :subject do
    name Faker::Name.name
    subject_duration Faker::Number.between(1, 8)
  end
end