FactoryGirl.define do
  factory :promotional_rule do
    name { Faker::Name.name }
    discount_type { %w(fixed percentage).sample }
    discount_mount { Faker::Number.decimal(2).to_f }
  end
end
