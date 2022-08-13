require 'rails_helper'

RSpec.describe PurchasePriceCalculator::Action do

  it 'calculates a total price factoring in discount from provided discount calculator' do
    item = create(:item, code: 'ITEM', name: 'Reedsy Item', price: 100)

    purchase_list = [
      { item: item, quantity: 1}
    ]

    stubbed_discount_calculator_class = class_double(DiscountCalculator::Action)

    example_discount = 25
    stubbed_discount_calculator = instance_double(DiscountCalculator::Action, call: example_discount)

    allow(stubbed_discount_calculator_class).to receive(:new).and_return(stubbed_discount_calculator)

    calculated_total_price = described_class.new(
      purchase_list: purchase_list,
      discount_calculator: stubbed_discount_calculator_class
    ).call

    expect(calculated_total_price).to eq(item.price - example_discount)
  end


end
