FactoryBot.define do
  factory :user do
    username { "#{Faker::Internet.username}-#{SecureRandom.hex(4)}" }
    password { "123456" }

    trait :email_notify do
      email_notification_enabled { true }
      email { Faker::Internet.email }
    end
  end

  factory :form_sign_up, class: User do
    username { "#{Faker::Internet.username}-#{SecureRandom.hex(4)}" }
    password { "123456" }
    password_confirmation { "123456" }
  end

  factory :form_sign_in, class: User do
    username { User.last.email }
    password { "123456" }
  end
end
