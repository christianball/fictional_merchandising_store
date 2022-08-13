require_relative '../errors/errors.rb'

class PurchaseList

  include ActiveModel::Validations

  def initialize(input:)
    @value = useable_purchase_list(input)
  end

  attr_reader :value

  private

  def useable_purchase_list(input)
    input.map do |purchase_params|
      item = Item.find(purchase_params['item_id'])

      quantity = purchase_params['quantity']

      raise(PurchaseListError, "Purchase quantity for item #{item.id} cannot be read") unless /\A\d+\Z/.match?(quantity)

      { item: item, quantity: quantity.to_i }
    end
  end

end
