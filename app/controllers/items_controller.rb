class ItemsController < ApplicationController
  skip_forgery_protection if: -> { Rails.env.development? }
  # To allow local API testing of updating item records by developers
  # otherwise get ActionController::InvalidAuthenticityToken in ItemsController#update

  def index
    @items = Item.all

    render json: @items.map { serialize_record(_1) }
  end

  def update
    @item = Item.find(params[:id])

    @item.update!(item_params)

    render json: serialize_record, status: 200
  end

  private

  def item_params
    params.require(:item).permit(:code, :name, :price)
  end

  def serialize_record(item=nil)
    (item || @item).as_json(except: [:created_at, :updated_at])
  end

end
