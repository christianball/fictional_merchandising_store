module DiscountCalculator
  module Discounts
    class Mug

      CODE = 'MUG'
      DISCOUNT_REQUIREMENT = 3
      DISCOUNT_PERCENTAGE_MULTIPLE = 0.3
      private_constant :CODE, :DISCOUNT_REQUIREMENT

      def initialize(purchase_list:)
        @purchase_list = purchase_list
      end

      def amount
        code_purchase_list = purchase_list.select { _1.fetch(:item).code == CODE }

        code_purchase_volume = code_purchase_list.pluck(:quantity).map(&:to_i).sum

        return 0 if code_purchase_volume < DISCOUNT_REQUIREMENT

        discount_amount = code_purchase_list.inject(0) do |discount, purchase|
          discounted_item_price = DISCOUNT_PERCENTAGE_MULTIPLE * purchase.fetch(:item).price
          discount + discounted_item_price * purchase.fetch(:quantity).to_i
        end
      end

      private

      attr_reader :purchase_list

    end
  end
end