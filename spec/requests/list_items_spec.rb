require 'rails_helper'

RSpec.describe 'Listing items', :type => :request do

  it 'lists all items with exactly the expected attributes' do
    item_one = create(:item, code: 'ONE', name: 'One', price: 11.11)
    item_two = create(:item, code: 'TWo', name: 'Two', price: 22.22)

    expected_response = [
      item_one.as_json(only: [:id, :code, :name, :price]),
      item_two.as_json(only: [:id, :code, :name, :price])
    ].to_json

    get '/items'

    expect(response).to have_http_status(:ok)
    expect(response.content_type).to eq('application/json; charset=utf-8')
    expect(response.body).to eq(expected_response)
  end

end
