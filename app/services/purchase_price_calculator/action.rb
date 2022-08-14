# frozen_string_literal: true

module PurchasePriceCalculator
  class Action
    def initialize(purchase_list:, discount_calculator: DiscountCalculator::Action)
      @purchase_list = purchase_list
      @discount_calculator = discount_calculator
    end

    def call
      purchase_list.total_price - total_discount
    end

    private

    attr_reader :purchase_list, :discount_calculator

    def total_discount
      discount_calculator.new(purchase_list: purchase_list).call
    end
  end
end
