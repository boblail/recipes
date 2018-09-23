FactoryBot.define do
  factory :recipe do
    name { "Factory Recipe" }
    ingredients { "1 cup of sugar" }
    instructions { "Factory Instructions" }

    association :created_by, factory: :user
    association :cookbook
  end
end
