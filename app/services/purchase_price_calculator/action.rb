module PurchasePriceCalculator
  class Action

    def initialize(purchase_list:)
      @purchase_list = purchase_list
    end

    def call
      total_price - total_discount
    end

    private

    attr_reader :purchase_list

    def total_price
      @total_price ||= purchase_list.reduce(0) do |total_cost, list_row|
        total_cost + individual_list_row_cost(list_row)
      end
    end

    def individual_list_row_cost(list_row)
      item_quantity = list_row.fetch(:quantity)
      item_price = list_row.fetch(:item).price

      item_quantity * item_price
    end

    def total_discount
      DiscountCalculator::Action.new(
        original_price: total_price, purchase_list: purchase_list
      ).call
    end

  end
end
