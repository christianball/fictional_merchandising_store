# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DiscountCalculator::ProductCodeDiscounts::Tshirt do
  it 'calculates and returns the correct discount amount' do
    tshirt_one = create(:item, code: 'TSHIRT', name: 'Tshirt One', price: 10.0)
    tshirt_two = create(:item, code: 'TSHIRT', name: 'Tshirt Two', price: 20.0)
    hoodie = create(:item, code: 'HOODIE', name: 'Hoodie', price: 30.0)

    purchase_list = [
      instance_double(Purchase, item: tshirt_one, quantity: 1),
      instance_double(Purchase, item: tshirt_two, quantity: 2),
      instance_double(Purchase, item: hoodie, quantity: 3)
    ]

    calculated_discount = described_class.new(purchase_list: purchase_list).amount

    expect(calculated_discount).to eq(15.0)
  end

  it 'returns 0 when discount is not applicable' do
    tshirt = create(:item, code: 'TSHIRT', name: 'Tshirt', price: 10.0)
    hoodie = create(:item, code: 'HOODIE', name: 'Hoodie', price: 30.0)

    purchase_list = [
      instance_double(Purchase, item: tshirt, quantity: 2),
      instance_double(Purchase, item: hoodie, quantity: 100)
    ]

    calculated_discount = described_class.new(purchase_list: purchase_list).amount

    expect(calculated_discount).to eq(0)
  end
end
