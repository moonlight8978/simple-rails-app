FactoryBot.define do
  factory :note do
    user { create(:user) }

    title { Faker::Lorem.sentence }
    content { Faker::Lorem.paragraph(sentence_count: 2, supplemental: true, random_sentences_to_add: 5) }

    trait :important do
      important { true }
    end

    trait :for_user do
      transient do
        username { nil }
      end

      user { User.find_by!(username: username) }
    end
  end
end
