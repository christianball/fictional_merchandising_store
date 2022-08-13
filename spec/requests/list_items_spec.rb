# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Listing items', type: :request do
  it 'returns 200, renders all items with expected values' do
    item_one = create(:item, code: 'ONE', name: 'One', price: 11.11)
    item_two = create(:item, code: 'TWo', name: 'Two', price: 22.22)

    expected_response = [
      item_one.as_json(except: %i[created_at updated_at]),
      item_two.as_json(except: %i[created_at updated_at])
    ].to_json

    get '/items'

    expect(response).to have_http_status(200)
    expect(response.content_type).to eq('application/json; charset=utf-8')
    expect(response.body).to eq(expected_response)
  end
end
