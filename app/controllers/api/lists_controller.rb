class Api::ListsController < ApplicationController
  before_action :authenticated?

  def index
    lists = @user.lists.all
    render json: lists, each_serializer: ListSerializer, status: 200
  end

  def create
    list = @user.lists.new(list_params)
    if list.valid?
      list.save!
      render json: list, status: 200
    else
      render json: { error: list.errors.full_messages }, status: :unprocessable_entity
  end


  def list_params
    params.require(:list).permit(:title, :description, :permission, :user_id)
  end
end
