class ProductRule < PromotionalRule
  attr_accessor :item, :required_quantity, :repeatable
  
  # validates :required_quantity, presence: true, numericality: { only_integer: true, greater_than: 0 }
  # validates :repeatable, presence: true, inclusion: { in: [true, false] }

  # def initialize item, required_quantity, repeatable
  #   super
  #   @item = item
  #   @repeatable = repeatable
  #   @required_quantity = required_quantity
  # end

  def initialize
  end

  def apply checkout
    if applied?(checkout) && repeatable
      apply!(checkout)
    elsif applicable?(checkout)
      apply_first_time(checkout)
    end
  end

  private
    def applicable? checkout
      checkout.items.count{ |co_item| co_item.code == item.code } >= required_quantity
    end

    def apply_percentage_discount checkout, times
      checkout.add_discount(mount(discount_mount) * times)
    end

    def apply_first_time checkout
      add_rule(checkout)
      apply_discount checkout, item.price, 2
    end

    def apply! checkout
      apply_discount checkout, item.price
    end

    def fixed_discount mount
      mount - discount_mount
    end
end
