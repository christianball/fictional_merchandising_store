class ItemsController < ApplicationController

  def index
    @items = Item.all

    render json: @items.map{ _1.as_json(except: [:created_at, :updated_at]) }
  end

end
