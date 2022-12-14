# frozen_string_literal: true

module DiscountCalculator
  module ProductCodeDiscounts
    class Tshirt
      CODE = 'TSHIRT'
      DISCOUNT_REQUIREMENT = 3
      DISCOUNT_PERCENTAGE_MULTIPLE = 0.3
      private_constant :CODE, :DISCOUNT_REQUIREMENT, :DISCOUNT_PERCENTAGE_MULTIPLE

      def initialize(purchase_list:)
        @purchase_list = purchase_list
        @code_purchase_list = code_purchase_list
        @code_purchase_volume = code_purchase_volume
      end

      def amount
        return 0 if code_purchase_volume < DISCOUNT_REQUIREMENT

        code_purchase_list.inject(0) do |discount, purchase|
          discounted_item_price = DISCOUNT_PERCENTAGE_MULTIPLE * purchase.item.price
          discount + discounted_item_price * purchase.quantity
        end
      end

      private

      attr_reader :purchase_list

      def code_purchase_list
        purchase_list.select { _1.item.code == CODE }
      end

      def code_purchase_volume
        code_purchase_list.sum(&:quantity)
      end
    end
  end
end
