FactoryGirl.define do
  factory :final_price_rule do
    name { Faker::Name.name }
    discount_type { %w(fixed percentage).sample }
    discount_mount { Faker::Number.decimal(2).to_f }
    required_money { Faker::Number.decimal(2).to_f }

    factory :fixed_final_price_rule do
      discount_type { 'fixed' }
    end

    factory :percentage_final_price_rule do
      discount_type { 'percentage' }
    end
  end
end
