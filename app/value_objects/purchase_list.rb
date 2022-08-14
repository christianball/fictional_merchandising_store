# frozen_string_literal: true

require_relative '../errors/errors'

class PurchaseList
  include Enumerable

  def initialize(input:)
    @list = build_purchase_list(input)
  end

  def each
    for item in @list do
      yield item
    end
  end

  def total_price
    list.reduce(0) do |total_cost, list_row|
      total_cost + individual_list_row_cost(list_row)
    end
  end

  def items
    list.pluck(:item)
  end

  private

  attr_reader :list

  def build_purchase_list(input)
    input.map do |purchase_params|
      item = Item.find(purchase_params['item_id'])

      quantity = purchase_params['quantity']

      raise(PurchaseListError, "Purchase quantity for item #{item.id} cannot be read") unless /\A\d+\Z/.match?(quantity)

      { item: item, quantity: quantity.to_i }
    end
  end

  def individual_list_row_cost(list_row)
    item_quantity = list_row.fetch(:quantity)
    item_price = list_row.fetch(:item).price

    item_quantity * item_price
  end
end
