FactoryGirl.define do
  factory :product_rule do
    name { Faker::Name.name }
    discount_type { %w(fixed percentage).sample }
    discount_mount { Faker::Number.decimal(2).to_f }
    required_quantity { Faker::Number.between(2, 10) }
    repeatable { Faker::Boolean.boolean }
    item { build(:item) }

    factory :fixed_product_rule do
      discount_type { 'fixed' }

      factory :lavender_heart_rule do
        name { 'lavender heart promo' }
        discount_mount { 8.50 }
        required_quantity { 2 }
        repeatable { true }
        item { build(:lavender_heart) }
      end
    end

    factory :percentage_product_rule do
      discount_type { 'percentage' }
    end
  end
end
