class Api::ItemsController < ApplicationController
  before_action :authenticated?

  def create
    item = @list.items.new(item_params)
    item.user = @list.user

    if item.valid?
      item.save!
      render json: item, status: 200
    else
      render json: { error: item.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def index
    items = @list.items.all
    render json: items, each_serializer: ItemSerializer, status: 200
  end

  private
  def item_params
    params.require(:item).permit(:name, :body, :completed, :list_id)
  end
end
