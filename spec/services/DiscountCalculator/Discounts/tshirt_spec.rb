require 'rails_helper'

RSpec.describe DiscountCalculator::Discounts::Tshirt do

  it 'calculates and returns the correct discount amount' do
    tshirt_one = create(:item, code: 'TSHIRT', name: 'Tshirt One', price: 10.0)
    tshirt_two = create(:item, code: 'TSHIRT', name: 'Tshirt Two', price: 20.0)
    hoodie = create(:item, code: 'HOODIE', name: 'Hoodie', price: 30.0)

    purchase_list = [
      {
        item: tshirt_one,
        quantity: '10'
      },
      {
        item: tshirt_two,
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

  it 'returns an amount 30% of combined tshirt costs when discount ceiling is reached' do
    tshirt_one = create(:item, code: 'TSHIRT', name: 'Tshirt One', price: 25.0)
    tshirt_two = create(:item, code: 'TSHIRT', name: 'Tshirt Two', price: 25.0)
    tshirt_three = create(:item, code: 'TSHIRT', name: 'Tshirt Three', price: 50.0)

    purchase_list = [
      {
        item: tshirt_one,
        quantity: '50'
      },
      {
        item: tshirt_two,
        quantity: '50'
      },
      {
        item: tshirt_three,
        quantity: '50'
      }
    ]

    calculated_discount = described_class.new(purchase_list: purchase_list).amount

    expect(calculated_discount).to eq(1500)
  end

  it 'returns 0 when discount is not applicable' do
    tshirt = create(:item, code: 'TSHIRT', name: 'Tshirt', price: 100.0)
    hoodie = create(:item, code: 'HOODIE', name: 'Hoodie', price: 30.0)

    purchase_list = [
      {
        item: tshirt,
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
