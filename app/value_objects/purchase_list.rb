# frozen_string_literal: true

class PurchaseList
  include Enumerable

  def initialize(list_data:)
    @list = build_purchase_list(list_data)
  end

  def each
    for item in @list do
      yield item
    end
  end

  def total_price
    list.reduce(0) do |total_cost, list_row|
      total_cost + list_row.quantity * list_row.item.price
    end
  end

  def items
    list.map(&:item)
  end

  private

  attr_reader :list

  def build_purchase_list(list_data)
    list_data.map do |list_data_row|
      Purchase.new(
        item_id: list_data_row['item_id'],
        quantity: list_data_row['quantity']
      )
    end
  end

  def individual_list_row_cost(list_row)
    list_row.quantity * list_row.item.price
  end
end
