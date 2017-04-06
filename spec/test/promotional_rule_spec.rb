require 'promotional_rule'
require 'checkout'

describe PromotionalRule do
  let(:promotional_rule) { build(:promotional_rule) }
  let(:checkout) { build(:checkout) }

  context 'when building' do
    it 'type' do
      expect(promotional_rule).to be_instance_of(PromotionalRule)
    end
  end

  context 'when building from factories has' do
    it 'name' do
      expect(promotional_rule.name).not_to be_nil
    end

    it 'discount_type' do
      expect(promotional_rule.discount_type).not_to be_nil
    end

    it 'discount_mount' do
      expect(promotional_rule.discount_mount).not_to be_nil
    end
  end

  describe "calling apply abstract method" do
    it "raises" do
      expect { promotional_rule.apply(checkout) }.to raise_error(NotImplementedError)
    end

    it "matches the error message" do
      expect { promotional_rule.apply(checkout) }.to raise_error('Subclasses must define `apply(checkout)`.')
    end
  end
end
