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
