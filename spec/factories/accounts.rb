FactoryBot.define do
  factory :account do
    name { Faker::Company.name }
    personal { false }
    association :owner, factory: :user

    trait :personal do
      personal { true }
      name { owner.name }
    end

    trait :team do
      personal { false }
    end

    trait :with_subdomain do
      subdomain { Faker::Internet.slug(glue: "-") }
    end
  end
end
