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
    apply_product_rule(item) if product_rule_include? item
  end

  def total
    apply_final_price_rules
    (@subtotal - @discount).round(2)
  end

  def add_discount mount
    @discount += mount
  end

  private
    def product_rule_include? item
      product_rules.map(&:item).map(&:code).include?(item.code)
    end

    def product_rules
      promotional_rules.select{ |pr| pr.instance_of?(ProductRule) }
    end

    def apply_product_rule item
      product_rules.find{ |pr| pr.item.code == item.code }.apply(self)
    end

    def apply_final_price_rules
      final_price_rules.each do |rule|
        rule.apply(self)
      end
    end

    def final_price_rules
      promotional_rules.select{ |pr| pr.instance_of?(FinalPriceRule) }
    end
end
