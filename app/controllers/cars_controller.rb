class CarsController < ApplicationController
  before_action :find_user, only: %i[index show create]

  def index
    @cars = @user.cars

    if @cars.any?
      render json: @cars
    else
      render json: { error: 'No cars found' }, status: 404
    end
  end

  def show
    @car = @user.cars.find(params[:id])

    if @car
      render json: @car
    else
      render json: { error: 'No car found' }, status: 404
    end
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
