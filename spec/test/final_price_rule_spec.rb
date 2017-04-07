require 'promotional_rule'
require 'final_price_rule'
require 'checkout'

describe FinalPriceRule do
  let(:final_price_rule) { build(:final_price_rule) }

  let(:fixed) { build(:fixed_final_price_rule, discount_mount: 50.0, required_money: 200.0) }
  let(:percentage) { build(:percentage_final_price_rule, discount_mount: 50.0, required_money: 200.0) }

  let(:applies_checkout) { build(:checkout, subtotal: 220.0) }
  let(:not_applies_checkout) { build(:checkout, subtotal: 100.0) }

  context 'when building' do
    it 'type' do
      expect(final_price_rule).to be_instance_of(FinalPriceRule)
    end
  end

  context 'when building from factories has' do
    it 'name' do
      expect(final_price_rule.name).not_to be_nil
    end

    it 'discount_type' do
      expect(final_price_rule.discount_type).not_to be_nil
    end

    it 'discount_mount' do
      expect(final_price_rule.discount_mount).not_to be_nil
    end

    it 'required_money' do
      expect(final_price_rule.required_money).not_to be_nil
    end
  end

  context 'when calling apply abstract method' do
    it 'respond' do
      expect(final_price_rule).to respond_to(:apply).with(1).argument
    end
  end

  context 'when try apply fixed discount' do
    context 'on applicable checkout' do
      before :each do
        fixed.apply applies_checkout
      end

      it 'modify checkout discount' do
        expect(applies_checkout.discount).to eq(fixed.discount_mount)
      end

      it 'added on applied rules for checkout' do
        expect(applies_checkout.applied_rules).not_to be_empty
      end

      it 'self promotional rule was added to applied rules for checkout' do
        expect(applies_checkout.applied_rules.find{ |ar| ar == fixed }).to eq(fixed)
      end
    end

    context 'on not applicable checkout' do
      before :each do
        fixed.apply not_applies_checkout
      end

      it 'not modify checkout discount' do
        expect(not_applies_checkout.discount).to eq(0)
      end

      it 'not added on applied rules for checkout' do
        expect(applies_checkout.applied_rules).to be_empty
      end
    end
  end

  context 'when try apply percentage discount' do
    context 'on applicable checkout' do
      before :each do
        percentage.apply applies_checkout
      end

      it 'modify checkout discount' do
        expect(applies_checkout.discount).to eq(applies_checkout.subtotal * (1 - (percentage.discount_mount / 100.0)))
      end

      it 'added on applied rules for checkout' do
        expect(applies_checkout.applied_rules).not_to be_empty
      end

      it 'self promotional rule was added to applied rules for checkout' do
        expect(applies_checkout.applied_rules.find{ |ar| ar == percentage }).to eq(percentage)
      end
    end

    context 'on not applicable checkout' do
      before :each do
        percentage.apply not_applies_checkout
      end

      it 'not modify checkout discount' do
        expect(not_applies_checkout.discount).to eq(0)
      end

      it 'not added on applied rules for checkout' do
        expect(applies_checkout.applied_rules).to be_empty
      end
    end
  end
end
