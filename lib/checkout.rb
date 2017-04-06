class Checkout
  attr_accessor :subtotal, :discount, :applied_rules, :promotional_rules, :items

  # def initialize promotional_rules
  #   @promotional_rules = promotional_rules
  #   @items = []
  #   @applied_rules = []
  #   @subtotal = 0
  #   @discount = 0
  # end

  def initialize
    @items = []
  end

  def scan item
    @items << item
    @subtotal += item.price
    promotional_rule(item).apply(self) if promotional_rule.include?(item)
  end

  def total
    @subtotal - @discount
  end

  def add_discount mount
    @discount += mount
  end

  private
    def promotional_rule item
      promotional_rules.find{ |pr| pr.item == item }
    end
end
