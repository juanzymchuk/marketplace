require 'promotional_rule'
require 'product_rule'
require 'final_price_rule'
require 'checkout'
require 'item'

describe Checkout do
  let(:lavender_heart) { build(:lavender_heart) }
  let(:other_lavender_heart) { build(:lavender_heart) }
  let(:custom_cufflink) { build(:custom_cufflink) }
  let(:kids_t_shirt) { build(:kids_t_shirt) }

  let(:lavender_heart_rule) { build(:lavender_heart_rule, item: lavender_heart) }
  let(:percentage_final_price_rule) { build(:percentage_final_price_rule)}

  let(:empty_checkout) { build(:checkout) }
  let(:checkout) { build(:checkout, promotional_rules: [lavender_heart_rule, percentage_final_price_rule]) }

  context 'when building' do
    it 'type' do
      expect(empty_checkout).to be_instance_of(Checkout)
    end
  end

  context 'when building from factories has' do
    it 'subtotal' do
      expect(empty_checkout.subtotal).to eq(0)
    end

    it 'discount' do
      expect(empty_checkout.discount).to eq(0)
    end

    it 'promotional_rules' do
      expect(empty_checkout.promotional_rules).to be_empty
    end

    it 'applied_rules' do
      expect(empty_checkout.applied_rules).to be_empty
    end

    it 'items' do
      expect(empty_checkout.items).to be_empty
    end
  end

  context 'when scanning items' do
    context 'whithout promotional rules' do
      before :each do
        empty_checkout.scan lavender_heart
        empty_checkout.scan custom_cufflink
        empty_checkout.scan kids_t_shirt
      end

      it 'increase items count' do
        expect(empty_checkout.items.count).to eq(3)
      end

      it 'modify subtotal' do
        expect(empty_checkout.subtotal).to eq([lavender_heart, custom_cufflink, kids_t_shirt].map(&:price).inject(:+))
      end

      it 'not modify discount' do
        expect(empty_checkout.discount).to eq(0)
      end

      it 'total return same subtotal' do
        expect(empty_checkout.total).to eq(empty_checkout.subtotal)
      end
    end

    context 'whit promotional rules' do
      before :each do
        checkout.scan lavender_heart
        checkout.scan other_lavender_heart
        checkout.scan custom_cufflink
        checkout.scan kids_t_shirt
      end

      let(:products_discounts) do
        diference = lavender_heart_rule.item.price - lavender_heart_rule.discount_mount
        items_quantity = checkout.items.count{ |item| item.code == lavender_heart_rule.item.code }
        diference * items_quantity
      end

      let(:subtotal) { [lavender_heart, other_lavender_heart, custom_cufflink, kids_t_shirt].map(&:price).inject(:+) }
      let(:final_price_discount) { (subtotal - products_discounts) * (percentage_final_price_rule.discount_mount / 100) }
      let(:total) { (checkout.subtotal - products_discounts - final_price_discount).round(2) }

      it 'increase items count' do
        expect(checkout.items.count).to eq(4)
      end

      it 'modify subtotal' do
        expect(checkout.subtotal).to eq(subtotal)
      end

      it 'modify discount' do
        expect(checkout.discount).to eq(products_discounts)
      end

      it 'total return mount that had applied product discount previously, and then apply final price discounts to final mount' do
        expect(checkout.total).to eq(total)
      end
    end
  end
end
