require 'promotional_rule'
require 'product_rule'
require 'checkout'
require 'item'

describe ProductRule do
  let(:product_rule) { build(:product_rule) }

  let(:fixed_rule) { build(:lavender_heart_rule) }
  let(:percentage_rule) { build(:lavender_heart_rule, discount_type: 'percentage', discount_mount: 50.0) }

  let(:lavender_heart_1) { build(:lavender_heart) }
  let(:lavender_heart_2) { build(:lavender_heart) }

  let(:applies_checkout) { build(:checkout, items:[lavender_heart_1, lavender_heart_2]) }
  let(:not_applies_checkout) { build(:checkout, items:[lavender_heart_1]) }

  context 'when building' do
    it 'type' do
      expect(product_rule).to be_instance_of(ProductRule)
    end
  end

  context 'when building from factories has' do
    it 'name' do
      expect(product_rule.name).not_to be_nil
    end

    it 'discount_type' do
      expect(product_rule.discount_type).not_to be_nil
    end

    it 'discount_mount' do
      expect(product_rule.discount_mount).not_to be_nil
    end

    it 'required_quantity' do
      expect(product_rule.required_quantity).not_to be_nil
    end

    it 'repeatable' do
      expect(product_rule.repeatable).not_to be_nil
    end
  end

  context "when calling apply abstract method" do
    it "respond" do
      expect(product_rule).to respond_to(:apply).with(1).argument
    end
  end

  context "when try apply fixed discount" do
    context "on applicable checkout" do
      before :each do
        fixed_rule.apply applies_checkout
      end

      it "modify checkout discount" do
        expect(applies_checkout.discount).to eq(fixed_rule.discount_mount * 2)
      end

      it "added on applied rules for checkout" do
        expect(applies_checkout.applied_rules).not_to be_empty
      end

      it "self promotional rule was added to applied rules for checkout" do
        expect(applies_checkout.applied_rules.find{ |ar| ar == fixed_rule }).to eq(fixed_rule)
      end
    end

    context "on not applicable checkout" do
      before :each do
        fixed_rule.apply not_applies_checkout
      end

      it "not modify checkout discount" do
        expect(not_applies_checkout.discount).to eq(0)
      end

      it "not added on applied rules for checkout" do
        expect(applies_checkout.applied_rules).to be_empty
      end
    end
  end

  context "when try apply percentage discount" do
    context "on applicable checkout" do
      before :each do
        percentage_rule.apply applies_checkout
      end

      let(:items_quantity) { applies_checkout.items.count{ |co_item| co_item.code == lavender_heart_1.code } }
      let(:item_price) { percentage_rule.item.price }
      let(:discount_percentage) { (1 - percentage_rule.discount_mount / 100.0) }

      it "modify checkout discount" do
        expect(applies_checkout.discount).to eq(items_quantity * item_price * discount_percentage)
      end

      it "added on applied rules for checkout" do
        expect(applies_checkout.applied_rules).not_to be_empty
      end

      it "self promotional rule was added to applied rules for checkout" do
        expect(applies_checkout.applied_rules.find{ |ar| ar == percentage_rule }).to eq(percentage_rule)
      end
    end

    context "on not applicable checkout" do
      before :each do
        percentage_rule.apply not_applies_checkout
      end

      it "not modify checkout discount" do
        expect(not_applies_checkout.discount).to eq(0)
      end

      it "not added on applied rules for checkout" do
        expect(applies_checkout.applied_rules).to be_empty
      end
    end
  end
end
