FactoryGirl.define do
  factory :item do
    name { Faker::Name.name }
    code { Faker::Code.ean }
    currency { Faker::Lorem.characters(1) }
    price { Faker::Number.decimal(2).to_f }

    factory :lavender_heart do
      name 'lavender heart'
      code '001'
      currency '£'
      price 9.25
    end

    factory :custom_cufflink do
      name 'custom cufflink'
      code '002'
      currency '£'
      price 45.00
    end

    factory :kids_t_shirt do
      name 'kids T-shirt'
      code '003'
      currency '£'
      price 19.95
    end
  end
end
