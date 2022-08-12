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

    @item.update!(item_params)

    render json: serialize_item, status: 200
  end

  def total
    @items = Item.where(id: purchase_list_params.pluck('item_id'))

    if @items.empty?
      render json: 'Error: No items of specified IDs exist', status: 404
    else
      total_price = PurchasePriceCalculator::Action.new(purchase_list: purchase_list).call

      render json: "Total price: £#{total_price}", status: 200
    end
  end

  private

  def item_params
    params.require(:item).permit(:code, :name, :price)
  end

  def purchase_list_params
    params.permit(list: [:item_id, :quantity])[:list]
  end

  def purchase_list
    purchase_list_params.map do |purchase|
      {
        item: @items.select { _1.id == purchase.fetch('item_id').to_i }.first,
        quantity: purchase.fetch('quantity')
      }
    end
  end

  def serialize_item(item=nil)
    (item || @item).as_json(except: [:created_at, :updated_at])
  end

end
