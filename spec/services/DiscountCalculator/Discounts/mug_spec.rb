# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DiscountCalculator::ProductCodeDiscounts::Mug do
  it 'calculates and returns the correct discount amount' do
    mug_one = create(:item, code: 'MUG', name: 'Mug One', price: 10.0)
    mug_two = create(:item, code: 'MUG', name: 'Mug Two', price: 20.0)
    hoodie = create(:item, code: 'HOODIE', name: 'Hoodie', price: 30.0)

    purchase_list = [
      {
        item: mug_one,
        quantity: '10'
      },
      {
        item: mug_two,
        quantity: '10'
      },
      {
        item: hoodie,
        quantity: '3'
      }
    ]

    calculated_discount = described_class.new(purchase_list: purchase_list).amount

    expect(calculated_discount).to eq(12.0)
  end

  it 'returns an amount 30% of combined mug costs when discount ceiling is reached' do
    mug_one = create(:item, code: 'MUG', name: 'Mug One', price: 25.0)
    mug_two = create(:item, code: 'MUG', name: 'Mug Two', price: 25.0)
    mug_three = create(:item, code: 'MUG', name: 'Mug Three', price: 50.0)

    purchase_list = [
      {
        item: mug_one,
        quantity: '50'
      },
      {
        item: mug_two,
        quantity: '50'
      },
      {
        item: mug_three,
        quantity: '50'
      }
    ]

    calculated_discount = described_class.new(purchase_list: purchase_list).amount

    expect(calculated_discount).to eq(1500)
  end

  it 'returns 0 when discount is not applicable' do
    mug = create(:item, code: 'MUG', name: 'Mug', price: 100.0)
    hoodie = create(:item, code: 'HOODIE', name: 'Hoodie', price: 30.0)

    purchase_list = [
      {
        item: mug,
        quantity: '9'
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
