# frozen_string_literal: true

require_relative '../errors/errors'

class Purchase

  def initialize(item_id:, quantity:)
    @item = usable_item(item_id)
    @quantity = usable_quantity(quantity)
  end

  attr_reader :item, :quantity

  private

  def usable_item(item_id)
    Item.find(item_id)
  end

  def usable_quantity(quantity)
    raise(PurchaseListError, "Purchase quantity for item #{item.id} cannot be read") unless /\A\d+\Z/.match?(quantity)

    quantity.to_i
  end

end
