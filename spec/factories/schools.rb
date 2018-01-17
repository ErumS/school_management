FactoryGirl.define do
  factory :school do
    name Faker::Name.name
    address Faker::Address.street_address
    phone_no Faker::PhoneNumber.cell_phone
  end
end