module DiscountCalculator
  module Discounts
    class Mug

      CODE = 'MUG'
      DISCOUNT_REQUIREMENT = 10
      DISCOUNT_CEILING_PURCHASE_VOLUME = 150
      DISCOUNT_CEILING_PERCENTAGE_MULTIPLE = 0.3

      private_constant :CODE, :DISCOUNT_REQUIREMENT

      def initialize(purchase_list:)
        @purchase_list = purchase_list
        @code_purchase_list = code_purchase_list
        @code_purchase_volume = code_purchase_volume
      end

      def amount
        return 0 if code_purchase_volume < DISCOUNT_REQUIREMENT

        discount_amount = code_purchase_list.inject(0) do |discount, purchase|
          discounted_item_price = discount_percentage_multiple * purchase.fetch(:item).price
          discount + discounted_item_price * purchase.fetch(:quantity).to_i
        end
      end

      private

      attr_reader :purchase_list, :code_purchase_list, :code_purchase_volume

      def code_purchase_list
        purchase_list.select { _1.fetch(:item).code == CODE }
      end

      def code_purchase_volume
        code_purchase_list.pluck(:quantity).map(&:to_i).sum
      end

      def discount_percentage_multiple
        if code_purchase_volume >= DISCOUNT_CEILING_PURCHASE_VOLUME
          DISCOUNT_CEILING_PERCENTAGE_MULTIPLE
        else
          discount_percentage_from_purchases
        end
      end

      def discount_percentage_from_purchases(index=1, discount_level_base=0, percentage=0)
        return percentage if index == code_purchase_volume + 1

        if index - discount_level_base == 10
          discount_percentage_from_purchases(index+=1, discount_level_base+=10, percentage+=0.02)
        else
          discount_percentage_from_purchases(index+=1, discount_level_base, percentage)
        end
      end

    end
  end
end
