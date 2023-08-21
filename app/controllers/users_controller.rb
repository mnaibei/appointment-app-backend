class UsersController < ApplicationController
  before_action :authenticate_devise_api_token!

  def index
    @users = User.all

    if @users
      render json: @users
    else
      render json: { error: 'No users found' }, status: 404
    end
  end

  def name
    @user_name = User.find(params[:id])
    render json: { name: @user_name.username }
  end

  def create
    @user = User.create(user_params)

    if @user.valid?
      render json: @user
    else
      render json: { error: 'Invalid user' }, status: 400
    end
  end

  def destroy
    @user = User.find(params[:id])

    if @user.destroy
      render json: @user
    else
      render json: { error: 'Unable to delete user' }, status: 400
    end
  end

  private

  def user_params
    params.permit(:username, :email, :password)
  end
end
