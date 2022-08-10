require 'rails_helper'

RSpec.describe 'Updating item', :type => :request do

  it 'renders 200, updates record with provided values, renders item with expected values' do
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

  it "renders 404 'item not found' when no item with provided ID exists in database" do
    put "/items/123456789", params: {
      "item" => {
        "code" => "TROUSERS",
        "name" => "Reedsy Trousers",
        "price" => "18.0"
      }
    }

    expect(response).to have_http_status(404)
    expect(response.body).to eq('item not found')
  end

  # it 'returns 422 unprocessable request if a required value is missing' do
  #   item = create(:item)
  #
  #   put "/items/#{item.id}", params: {
  #     "item" => {
  #       "code" => "TROUSERS",
  #       "name" => "Reedsy Trousers",
  #       "price" => nil
  #     }
  #   }
  #
  #   expect(response).to have_http_status(422)
  #   expect(response.body).to eq('unprocessable request')
  # end

end
