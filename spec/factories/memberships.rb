FactoryBot.define do
  factory :membership do
    association :user
    association :account
    role { "member" }
    status { "active" }

    trait :owner do
      role { "owner" }
    end

    trait :admin do
      role { "admin" }
    end

    trait :member do
      role { "member" }
    end

    trait :invited do
      status { "invited" }
    end

    trait :deactivated do
      status { "deactivated" }
    end
  end
end
