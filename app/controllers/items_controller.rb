class ItemsController < ApplicationController

  skip_forgery_protection if: -> { Rails.env.development? }
  # To allow local API testing of updating item records by developers
  # otherwise get ActionController::InvalidAuthenticityToken in ItemsController#update

  def index
    @items = Item.all

    render json: @items.map { serialize_item(_1) }
  end

  def update
    @item = Item.find(params[:id])

    item_params = params.require(:item).permit(:code, :name, :price)

    @item.update!(item_params)

    render json: serialize_item, status: 200
  end

  def total
    purchase_list = params.permit(list: [:item_id, :quantity])[:list]

    total_price = TotalPriceCalculator.new(purchase_list: purchase_list).call

    render json: "Total price: #{total_price}", status: 200
  end

  private

  def serialize_item(item=nil)
    (item || @item).as_json(except: [:created_at, :updated_at])
  end

end
