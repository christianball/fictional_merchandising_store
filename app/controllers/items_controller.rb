class ItemsController < ApplicationController

  def index
    @items = Item.all

    render json: @items.map{ _1.as_json(only: [:id, :code, :name, :price]) }
  end

end
