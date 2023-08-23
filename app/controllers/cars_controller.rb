class CarsController < ApplicationController
  before_action :authenticate_devise_api_token!, except: %i[index], unless: -> { Rails.env.test?}
  before_action :find_user, except: %i[index]
  before_action :find_car, only: %i[show destroy]

  def index
    @cars = Car.includes(:user).all

    if @cars.any?
      render json: @cars, include: :user
    else
      render json: { error: 'No cars found' }, status: 404
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
    if @car.user == @user # Check if the current user is the owner of the car
      if @car.destroy
        render json: @car
      else
        render json: { error: 'Unable to delete car' }, status: 400
      end
    else
      render json: { error: 'Unauthorized to delete this car' }, status: 401
    end
  end

  private

  def find_user
    @user = User.find(params[:user_id])
  end

  def find_car
    @car = Car.find(params[:id])
  end

  def car_params
    params.permit(:car_model, :description, :photo, :reservation_price, :user_id)
  end
end
