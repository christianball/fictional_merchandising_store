require 'rails_helper'

RSpec.describe DiscountCalculator::Discounts::Mug do

  it 'calculates and returns the correct discount amount' do
    mug_one = create(:item, code: 'MUG', name: 'Mug One', price: 10.0)
    mug_two = create(:item, code: 'MUG', name: 'Mug Two', price: 20.0)
    hoodie = create(:item, code: 'HOODIE', name: 'Hoodie', price: 30.0)

    purchase_list = [
      {
        item: mug_one,
        quantity: '1'
      },
      {
        item: mug_two,
        quantity: '2'
      },
      {
        item: hoodie,
        quantity: '3'
      }
    ]

    calculated_discount = described_class.new(purchase_list: purchase_list).amount

    expect(calculated_discount).to eq(15.0)
  end

  it 'returns 0 when discount is not applicable' do
    mug = create(:item, code: 'MUG', name: 'Mug', price: 10.0)
    hoodie = create(:item, code: 'HOODIE', name: 'Hoodie', price: 30.0)

    purchase_list = [
      {
        item: mug,
        quantity: '2'
      },
      {
        item: hoodie,
        quantity: '100'
      }
    ]

    calculated_discount = described_class.new(purchase_list: purchase_list).amount

    expect(calculated_discount).to eq(0)
  end

end
