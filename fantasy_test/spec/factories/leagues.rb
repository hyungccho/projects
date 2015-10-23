FactoryGirl.define do
  factory :league do
    name { Faker::Internet.user_name }
  end
end
