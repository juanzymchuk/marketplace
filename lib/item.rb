class Item
  attr_accessor :name, :code, :currency, :price
  # validates :name, :code, :currency, :price, presence: true
  # validates :price, numericality: { greater_than: 0 }

  # This must receive :name, :code, :currency, :price
  #  def initialize name, code, currency, price
  #    @name = name
  #    @code = code
  #    @currency = currency
  #    @price = price
  #  end

  def initialize
  end
end

# item = Market::Item.new('Lavender heart', '001', '£', 9.25)
# item = Market::Item.new('Custom cufflinks', '002', '£', 45.00)
# item = Market::Item.new('Kids T-shirt', '003', '£', 19.95)
