module DiscountCalculator
  class Action

    DISCOUNTS = {
      'MUG' => Discounts::Mug,
      'TSHIRT' => Discounts::Tshirt
    }
    private_constant :DISCOUNTS

    def initialize(original_price:, purchase_list:)
      @original_price = original_price
      @purchase_list = purchase_list
    end

    def call
      product_code_discounts_total
    end

    private

    attr_reader :original_price, :purchase_list

    def product_code_discounts_total
      purchase_list.pluck(:item).pluck(:code).inject(0) do |discount_total, item_code|
        discount = DISCOUNTS[item_code]

        if discount.present?
          discount_total + discount.new(purchase_list: purchase_list).amount
        else
          discount_total
        end
      end
    end

  end
end
