FactoryGirl.define do
  factory :recipe do
    name "Factory Recipe"
    ingredients "Factory Ingredients"
    instructions "Factory Instructions"

    association :created_by, factory: :user
    association :cookbook
  end
end
