class FinalPriceRule < PromotionalRule
  attr_accessor :required_money
  # validates :required_money, presence: true

  # def initialize required_money
  #   super
  #   @required_money = required_money
  # end

  def initialize
  end

  def apply checkout
    apply! checkout if applicable?(checkout) && !applied?(checkout)
  end

  private
    def applicable? checkout
      checkout.subtotal >= required_money
    end

    def apply! checkout
      add_rule checkout
      apply_discount checkout, (checkout.subtotal - checkout.discount)
    end

    def fixed_discount mount
      discount_mount
    end
end
