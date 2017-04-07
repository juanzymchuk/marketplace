FactoryGirl.define do
  factory :final_price_rule do
    name { Faker::Name.name }
    discount_type { %w(fixed percentage).sample }
    discount_mount { Faker::Number.decimal(2).to_f }
    required_spend { Faker::Number.decimal(2).to_f }

    factory :fixed_final_price_rule do
      discount_type { 'fixed' }
    end

    factory :percentage_final_price_rule do
      name { 'spend over £60' }
      discount_type { 'percentage' }
      discount_mount { 10.0 }
      required_spend { 60.0 }
    end
  end
end
