require 'rails_helper'

RSpec.describe 'Checking total price', :type => :request do

  it 'works out the total price' do
    item = create(:item, code: 'ITEM', name: 'item', price: 10.1)

    post '/items/total', params: {
      "list": [
          {
              "item_id": "#{item.id}",
              "quantity": "5"
          }
      ]
    }

    expect(response).to have_http_status(200)
    expect(response.content_type).to eq('application/json; charset=utf-8')
    expect(response.body).to eq("Total price: 50.5")
  end

end
