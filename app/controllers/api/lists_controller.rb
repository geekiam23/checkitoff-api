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

  def show
    list = list.find(params[:id])
    render json: lists, status: 200
  end

  def destroy
    begin
      list = List.find(params[:id])
      list.destroy
      render json: {}, status: :no_content
    rescue ActiveRecord::RecordNotFound
      render :json => {}, :status => :not_found
    end
  end

  def update
    list = List.find(params[:id])
    if list.update(list_params)
      render json: list
    else
      render json: { errors: list.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private
  def list_params
    params.require(:list).permit(:title, :description, :permission, :user_id)
  end
end
