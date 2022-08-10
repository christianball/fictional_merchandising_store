require 'rails_helper'

RSpec.describe 'Updating item', :type => :request do

  it 'returns 200 with expected response and updates record with provided values' do
    item = create(:item)

    put "/items/#{item.id}", params: {
      "item" => {
        "code" => "TROUSERS",
        "name" => "Reedsy Trousers",
        "price" => "18.0"
      }
    }

    expect(response).to have_http_status(200)
    expect(item.reload).to have_attributes(code: 'TROUSERS', name: 'Reedsy Trousers', price: 18.0)
    expect(response.body).to eq(
      "{\"code\":\"TROUSERS\",\"name\":\"Reedsy Trousers\",\"price\":\"18.0\",\"id\":#{item.id}}"
    )
  end

  it "returns 404 with expected response when no item with provided ID exists in database" do
    put "/items/123456789", params: {
      "item" => {
        "code" => "TROUSERS",
        "name" => "Reedsy Trousers",
        "price" => "18.0"
      }
    }

    expect(response).to have_http_status(404)
    expect(response.body).to eq("{\"error\":\"No entry found with ID 123456789.\"}")
  end

  it 'returns 422 with expected response when a provided value is invalid' do
    item = create(:item)

    put "/items/#{item.id}", params: {
      "item" => {
        "code" => "T",
        "name" => nil,
        "price" => "0.9"
      }
    }

    expect(response).to have_http_status(422)
    expect(response.body).to include(
      "code\":[\"is too short (minimum is 2 characters)",
      "name\":[\"can't be blank\"",
      "price\":[\"must be greater than or equal to 1\""
    )
  end

end
