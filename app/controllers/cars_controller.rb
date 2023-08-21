class CarsController < ApplicationController
  before_action :authenticate_devise_api_token!

  def index
    # @user = User.find(params[:user_id])
    # @cars = @user.cars
    @cars = Car.all

    if @cars
      render json: @cars
    else
      rescue_from ActiveRecord::RecordNotFound do |_exception|
        render json: { error: 'No cars found' }, status: 404
      end
    end
  end

  def show
    @user = User.find(params[:user_id])
    @car = @user.cars.find(params[:id])

    if @car
      render json: @car
    else
      render json: { error: 'No car found' }, status: 404
    end
  end

  def create
    @car = Car.create(car_params)
    @user = User.find(params[:user_id])
    @car.user = @user

    if @car.valid?
      if @car.save
        render json: @car
      else
        render json: { error: 'Unable to save car' }, status: 400
      end
    else
      render json: { error: 'Invalid car' }, status: 400
    end
  end

  def destroy
    @car = Car.find(params[:id])

    if @car.destroy
      render json: @car
    else
      render json: { error: 'Unable to delete car' }, status: 400
    end
  end

  private

  def car_params
    params.permit(:car_model, :description, :photo, :reservation_price, :user_id)
  end
end
