class Api::UsersController < ApplicationController
  before_action :authenticate_user!, :except => [:show]

  def index
   @users = User.all
   render json: @users, each_serializer: UserSerializer
   @auth_token = response["auth_token"]
  end

  def new
    @user = User.new
  end

  def create
    user = User.new(user_params)
    if user.save
      render json: { user: user }
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def show
    user = User.find(params[:id])
    render json: { user: user }
  end

  def destroy
    begin
      @user = User.find(params[:id])
      @user.destroy
      render json: { message: "HTTP 204 No Content. User deleted Successfully" }, status: :no_content
    rescue ActiveRecord::RecordNotFound
      render :json => { errors: "User not found. Command failed." }, :status => :not_found
    end
  end

  private
  def user_params
    params.require(:user).permit(:email, :password, :auth_token)
  end

  # Overwriting the sign_out redirect path method
  def after_sign_out_path_for(resource_or_scope)
    root_path
  end
end
