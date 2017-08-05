class Api::ItemsController < ApplicationController
  before_action :authenticated?

  def index
    @item = @list.items.all
    render json: @item, each_serializer: ItemsSerializer
  end

  def create
    @list - List.find(params[:list_id])
    @item = Item.new(item_params)

    if @item.save
      render json: @item.to_json
    else
      render json: { error: item.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def show
    item = item.find(params[:id])
    render json: item, status: 200
  end

  def update
    begin
      @item = Item.find(item_params[:id])
      if @item.update(item_params)
        render json: @item.to_json
      else
        render json: { errors: item.errors.full_messages }, status: :unprocessable_entity
      end
    rescue ActiveRecord::RecordNotFound
      render :json => { errors: "Item not found. Command failed."}
    end
  end

  private
  def item_params
    params.require(:item).permit(:name, :description, :completed, :list_id)
  end
end
