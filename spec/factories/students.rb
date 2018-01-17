FactoryGirl.define do
  factory :student do
    name Faker::Name.name
    address Faker::Address.street_address
    phone_no Faker::PhoneNumber.cell_phone
    percentage Faker::Number.decimal(2, 2)
  end
end