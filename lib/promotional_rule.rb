class PromotionalRule
  attr_accessor :name, :discount_type, :discount_mount
  # validates :name, :discount_type, :discount_mount, presence: true
  # validates :discount_type, inclusion: { in: discount_types.keys }
  # validates :discount_mount, numericality: { greater_than: 0 }
  # enum discount_type: %w(percentage fixed).freeze

  # def initialize name, discount_type, discount_mount
  #   @name = name
  #   @discount_type = discount_type
  #   @discount_mount = discount_mount
  # end

  def initialize
  end

  def apply checkout
    raise NotImplementedError, "Subclasses must define `apply(checkout)`."
  end

  private

    def applied? checkout
      checkout.applied_rules.find{ |ar| ar.promotional_rule == self }.present?
    end

    def applicable? checkout
      raise NotImplementedError, "Subclasses must define `applicable?`."
    end

    def apply! checkout, times = 1
      checkout.add_discount(discount_mount * times)
    end

    def apply_discount checkout, times = 1, mount
      checkout.add_discount(send("#{discount_type}_discount", mount) * times)
    end

    def fixed_discount mount
      mount - discount_mount
    end

    def percentage_discount checkout, times
      raise NotImplementedError, "Subclasses must define `apply_percentage_discount`."
    end

    def mount discount
      mount * (1 - (discount_mount/100.0))
    end

    def add_rule checkout
      checkout.applied_rules << self
    end
end
