class UsersController < ApplicationController
  def index
    @users = User.all

    if @users
      render json: @users
    else
      render json: { error: 'No users found' }, status: 404
    end
  end

  def create
    @user = User.create(username: params[:username])

    if @user.valid?
      render json: @user
    else
      render json: { error: 'Invalid user' }, status: 400
    end
  end
end
