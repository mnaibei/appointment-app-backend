class CarsController < ApplicationController
  before_action :authenticate_devise_api_token!

  def index
    # @user = User.find(params[:user_id])
    # @cars = @user.cars
    @cars = Car.all

    if @cars.any?
      render json: @cars
    else
      rescue_from ActiveRecord::RecordNotFound do |_exception|
        render json: { error: 'No cars found' }, status: 404
      end
    end
  end

  def show
    @car = @user.cars.find(params[:id])
    render json: @car
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'No car found' }, status: 404
  end

  def create
    @car = @user.cars.build(car_params)

    if @car.save
      render json: @car
    else
      render json: { error: 'Unable to save car' }, status: 400
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

  def find_user
    @user = User.find(params[:user_id])
  end

  def car_params
    params.permit(:car_model, :description, :photo, :reservation_price)
  end
end
