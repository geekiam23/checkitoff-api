class Api::ItemsController < ApiController


  def index
    @items = Items.all
    render json: @items, each_serializer: ItemsSerializer
  end

  def create
    @list = List.find(params[:list_id])
    @item = @list.items.build(item_params)

    if @item.save
      render json: @item.to_json
    else
      render json: { error: @item.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def show
    @item = item.find(params[:id])
    render json: item, status: 200
  end

  def update
    @item = Item.find(params[:id])

    if @item.update(item_params)
      render json: item
    else
      render json: { errors: item.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private
  def item_params
    params.require(:item).permit(:name, :description, :completed, :list_id)
  end
end
