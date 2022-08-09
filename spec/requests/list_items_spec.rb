require 'rails_helper'

RSpec.describe 'Listing items', :type => :request do

  it 'lists all items with exactly the expected attributes' do
    item = create(:item, code: 'ONE', name: 'One', price: 11.11)

    expected_response = [
      {
        id: item.id,
        code: item.code,
        name: item.name,
        price: item.price
      }
    ].to_json

    get '/items'

    expect(response).to have_http_status(:ok)
    expect(response.content_type).to eq('application/json; charset=utf-8')
    expect(response.body).to eq(expected_response)
  end

end
