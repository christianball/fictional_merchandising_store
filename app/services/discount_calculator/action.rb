# frozen_string_literal: true

module DiscountCalculator
  class Action
    DISCOUNTS = {
      'MUG' => ProductCodeDiscounts::Mug,
      'TSHIRT' => ProductCodeDiscounts::Tshirt
    }.freeze
    private_constant :DISCOUNTS

    def initialize(purchase_list:)
      @purchase_list = purchase_list
    end

    def call
      product_code_discounts_total
    end

    private

    attr_reader :original_price, :purchase_list

    def product_code_discounts_total
      purchase_list.items.pluck(:code).inject(0) do |discount_total, item_code|
        return discount_total if DISCOUNTS[item_code].nil?

        discount_total + DISCOUNTS[item_code].new(purchase_list: purchase_list).amount
      end
    end
  end
end
