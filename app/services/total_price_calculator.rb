class TotalPriceCalculator

  def initialize(purchase_list:)
    @purchase_list = purchase_list
  end

  def call
    total_price
  end

  private

  attr_reader :purchase_list

  def total_price
    purchase_list.reduce(0) do |total_cost, list_row|
      total_cost + individual_list_row_cost(list_row)
    end
  end

  def individual_list_row_cost(list_entry)
    item_quantity = list_entry.fetch('quantity').to_i
    item_price = featured_items.select { _1.id == list_entry.fetch('item_id').to_i }.first.price

    item_quantity * item_price
  end

  def featured_items
    @featured_items ||= Item.where(id: purchase_list.pluck('item_id'))
  end

end
