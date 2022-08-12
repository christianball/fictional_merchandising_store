require 'rails_helper'

RSpec.describe TotalPriceCalculator do

  it 'calculates the total price from a purchase list' do
    mug = create(:item, code: 'MUG', name: 'mug', price: 6.00)
    tshirt = create(:item, code: 'TSHIRT', name: 'tshirt', price: 15.00)
    hoodie = create(:item, code: 'HOODIE', name: 'hoodie', price: 20.00)

    purchase_list = [
      { "item_id"=>"#{mug.id}", "quantity"=>"2" },
      { "item_id"=>"#{tshirt.id}", "quantity"=>"4" },
      { "item_id"=>"#{hoodie.id}", "quantity"=>"1" }
    ]

    calculated_total_price = described_class.new(purchase_list: purchase_list).call

    expect(calculated_total_price).to eq(92)
  end

end
