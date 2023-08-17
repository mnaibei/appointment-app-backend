class CarsController < ApplicationController
  def index
    @cars = Car.all

    if @cars
      render json: @cars
    else
      render json: { error: 'No cars found' }, status: 404
    end
  end

  def show
    @car = Car.find(params[:id])

    if @car
      render json: @car
    else
      render json: { error: 'No car found' }, status: 404
    end
  end

  def create
    @car = Car.create(car_params)

    if @car.valid?
      render json: @car
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
