require 'rails_helper'

RSpec.describe PurchasePriceCalculator::Action do

  it 'calculates the total price from a purchase list' do
    tshirt = create(:item, code: 'TSHIRT', name: 'Tshirt', price: 6.00)
    mug = create(:item, code: 'MUG', name: 'Mug', price: 15.00)
    hoodie = create(:item, code: 'HOODIE', name: 'hoodie', price: 20.00)

    purchase_list = [
      { item: tshirt, quantity: '2' },
      { item: mug, quantity: '4'},
      { item: hoodie, quantity: '1'}
    ]

    calculated_total_price = described_class.new(purchase_list: purchase_list).call

    expect(calculated_total_price).to eq(92)
  end

end
