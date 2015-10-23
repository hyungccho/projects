FactoryGirl.define do
  factory :user do
    session_token { SecureRandom.urlsafe_base64 }

    factory :valid_user do
    username { Faker::Internet.user_name }
      password "testtest"
    end

    factory :invalid_user do
      username "invaliduser"
      password "test"
    end

    factory :duplicate_user do
      username "duplicate"
      password "duplicate"
    end
  end
end
