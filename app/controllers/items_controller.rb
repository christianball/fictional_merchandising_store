# frozen_string_literal: true

require_relative '../errors/errors'
require_relative '../value_objects/purchase_list'

class ItemsController < ApplicationController
  skip_forgery_protection if: -> { Rails.env.development? }
  # To allow local API testing of updating item records by developers
  # otherwise get ActionController::InvalidAuthenticityToken in ItemsController#update

  rescue_from PurchaseListError do |e|
    render(
      json: { errors: e.message },
      status: 422
    )
  end

  def index
    @items = Item.all

    render json: @items.map { serialize_item(_1) }
  end

  def update
    @item = Item.find(params[:id])

    @item.update!(item_params)

    render json: serialize_item, status: 200
  end

  def total
    purchase_list = PurchaseList.new(list_data: purchase_list_params)
    total_price = PurchasePriceCalculator::Action.new(purchase_list: purchase_list).call

    render json: "Total price: £#{total_price}", status: 200
  end

  private

  def item_params
    params.require(:item).permit(:code, :name, :price)
  end

  def purchase_list_params
    params.permit(list: %i[item_id quantity])[:list]
  end

  def serialize_item(item = nil)
    (item || @item).as_json(except: %i[created_at updated_at])
  end
end
