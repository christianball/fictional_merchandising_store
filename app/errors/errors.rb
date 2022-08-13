# frozen_string_literal: true

class PurchaseListError < StandardError
  def initialize(msg = 'Something is wrong with the purchase list')
    super
  end
end
