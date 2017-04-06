FactoryGirl.define do
  factory :checkout do
    subtotal { 0 }
    discount { 0 }
    promotional_rules { [] }
    applied_rules { [] }
  end
end
