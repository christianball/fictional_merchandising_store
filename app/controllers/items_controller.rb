class ItemsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    @items = Item.all

    render json: @items.map{ _1.as_json(except: [:created_at, :updated_at]) }
  end

  def update
    @item = Item.find_by(id: params[:id])

    if @item.nil?
      render json: 'item not found', status: 404
    elsif @item.update(item_params)
      render json: @item.as_json(except: [:created_at, :updated_at])
    else
      render json: 'unprocessable request', status: 422
    end
  end

  private

  def item_params
    params.require(:item).permit(:code, :name, :price)
  end

end
