class FinalPriceRule < PromotionalRule
  attr_accessor :required_spend

  # validates :required_spend, presence: true

  # def initialize required_spend
  #   super
  #   @required_spend = required_spend
  # end

  def initialize
  end

  def apply checkout
    apply! checkout if applicable?(checkout) && !applied?(checkout)
  end

  private
    def applicable? checkout
      checkout.subtotal >= required_spend
    end

    def apply! checkout
      add_rule checkout
      apply_discount checkout, (checkout.subtotal - checkout.discount)
    end

    def fixed_discount mount
      discount_mount
    end
end
