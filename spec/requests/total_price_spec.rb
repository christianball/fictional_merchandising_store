require 'rails_helper'

RSpec.describe 'Checking total price', :type => :request do

  let(:mug) { create(:item, code: 'MUG', name: 'Reedsy Mug', price: 6) }
  let(:tshirt) { create(:item, code: 'TSHIRT', name: 'Reedsy Tshirt', price: 15) }
  let(:hoodie) { create(:item, code: 'HOODIE', name: 'Reedsy Hoodie', price: 20) }

  it 'returns status: 200 and price: £41.0 for shopping list: 1 MUG, 1 TSHIRT, 1 HOODIE' do
    post '/items/total', params: {
      "list": [
          {
              "item_id": "#{mug.id}",
              "quantity": "1"
          },
          {
              "item_id": "#{tshirt.id}",
              "quantity": "1"
          },
          {
              "item_id": "#{hoodie.id}",
              "quantity": "1"
          }
      ]
    }

    expect(response.content_type).to eq('application/json; charset=utf-8')
    expect(response).to have_http_status(200)
    expect(response.body).to eq('Total price: £41.0')
  end

  it 'returns status: 200 and price: £69.0 for shopping list: 9 MUG, 1 TSHIRT' do
    post '/items/total', params: {
      "list": [
          {
              "item_id": "#{mug.id}",
              "quantity": "9"
          },
          {
              "item_id": "#{tshirt.id}",
              "quantity": "1"
          }
      ]
    }

    expect(response.content_type).to eq('application/json; charset=utf-8')
    expect(response).to have_http_status(200)
    expect(response.body).to eq('Total price: £69.0')
  end

  it 'returns status: 200 and price: £73.8 for shopping list: 10 MUG, 1 TSHIRT' do
    post '/items/total', params: {
      "list": [
          {
              "item_id": "#{mug.id}",
              "quantity": "10"
          },
          {
              "item_id": "#{tshirt.id}",
              "quantity": "1"
          }
      ]
    }

    expect(response.content_type).to eq('application/json; charset=utf-8')
    expect(response).to have_http_status(200)
    expect(response.body).to eq('Total price: £73.8')
  end

  it 'returns status: 200 and price: £279.9 for shopping list: 45 MUG, 3 TSHIRT' do
    post '/items/total', params: {
      "list": [
          {
              "item_id": "#{mug.id}",
              "quantity": "45"
          },
          {
              "item_id": "#{tshirt.id}",
              "quantity": "3"
          }
      ]
    }

    expect(response.content_type).to eq('application/json; charset=utf-8')
    expect(response).to have_http_status(200)
    expect(response.body).to eq('Total price: £279.9')
  end

  it 'returns status: 200 and price: £902.0 for shopping list: 45 MUG, 3 TSHIRT' do
    post '/items/total', params: {
      "list": [
          {
              "item_id": "#{mug.id}",
              "quantity": "200"
          },
          {
              "item_id": "#{tshirt.id}",
              "quantity": "4"
          },
          {
              "item_id": "#{hoodie.id}",
              "quantity": "1"
          }
      ]
    }

    expect(response.content_type).to eq('application/json; charset=utf-8')
    expect(response).to have_http_status(200)
    expect(response.body).to eq('Total price: £902.0')
  end

  it 'returns status: 404 with error message if no specified items are found in database' do
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
    expect(response.body).to eq("{\"error\":\"Couldn't find Item with 'id'=123456\"}")
  end

  it 'returns status: 422 with error message if a purchase quantity cannot be read' do
    post '/items/total', params: {
      "list": [
          {
              "item_id": "#{mug.id}",
              "quantity": "A"
          }
      ]
    }

    expect(response.content_type).to eq('application/json; charset=utf-8')
    expect(response).to have_http_status(422)
    expect(response.body).to eq("{\"errors\":\"Purchase quantity for item #{mug.id} cannot be read\"}")
  end

end
