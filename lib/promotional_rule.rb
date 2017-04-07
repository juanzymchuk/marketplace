require 'active_support/core_ext/object/blank'

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
    raise NotImplementedError, 'Subclasses must define `apply(checkout)`.'
  end

  private

    def applied? checkout
      checkout.applied_rules.find{ |ar| ar == self }.present?
    end

    def applicable? checkout
      raise NotImplementedError, 'Subclasses must define `applicable?`.'
    end

    def apply_discount checkout, mount, times = 1
      checkout.add_discount(send("#{discount_type}_discount", mount) * times)
    end

    def percentage_discount mount
      mount * (discount_mount / 100.0)
    end


    def fixed_discount
      raise NotImplementedError, 'Subclasses must define `fixed_discount`.'
    end

    def add_rule checkout
      checkout.applied_rules << self
    end
end
