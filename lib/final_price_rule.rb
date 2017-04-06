class FinalPriceRule < PromotionalRule
  attr_accessor :required_money
  # validates :required_money, presence: true

  # def initialize required_money
  #   super
  #   @required_money = required_money
  # end

  def initialize
    super
  end

  def apply checkout
    apply! checkout if applicable?(checkout) && !applied?(checkout)
  end

  private
    def apply! checkout
      add_rule checkout
      apply_discount checkout, checkout.subtotal
    end

    def applicable? checkout
      checkout.subtotal - checkout.discount >= required_money
    end
end
