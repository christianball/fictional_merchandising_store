require 'rails_helper'

RSpec.describe 'Checking total price', :type => :request do

  it 'returns 200 with expected response' do
    item = create(:item, code: 'MUG', name: 'mug', price: 20)

    post '/items/total', params: {
      "list": [
          {
              "item_id": "#{item.id}",
              "quantity": "5"
          }
      ]
    }

    expect(response.content_type).to eq('application/json; charset=utf-8')
    expect(response).to have_http_status(200)
    expect(response.body).to eq("Total price: £70.0")
  end

  it 'returns 404 with expected response when none of the specified items are found in database' do
    post '/items/total', params: {
      "list": [
          {
              "item_id": "123456",
              "quantity": "5"
          }
      ]
    }

    expect(response.content_type).to eq('application/json; charset=utf-8')
    expect(response).to have_http_status(404)
    expect(response.body).to eq('Error: No items of specified IDs exist')
  end

end
