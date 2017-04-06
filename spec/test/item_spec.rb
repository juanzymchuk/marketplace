require 'item'

describe Item do
  let(:item) { build(:item) }
  let(:lavender_heart) { build(:lavender_heart) }
  let(:custom_cufflink) { build(:custom_cufflink) }
  let(:kids_t_shirt) { build(:kids_t_shirt) }

  context 'when building' do
    it 'type' do
      expect(item).to be_instance_of(Item)
    end
  end

  context 'when building from factories' do
    context 'has correct' do
      it 'name' do
        expect(lavender_heart.name).to eq('lavender heart')
      end

      it 'code' do
        expect(custom_cufflink.code).to eq('002')
      end

      it 'currency' do
        expect(kids_t_shirt.currency).to eq('£')
      end

      it 'price' do
        expect(kids_t_shirt.price).to eq(19.95)
      end
    end
  end
end
