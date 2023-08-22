class ReservationsController < ApplicationController
  before_action :authenticate_devise_api_token!
  load_and_authorize_resource

  def index
    @user = User.find(params[:user_id])
    @reservations = @user.reservations
    render json: @reservations
  end

  def show
    @user = User.find(params[:user_id])
    @reservation = @user.reservations.find(params[:id])
    render json: @reservation
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Reservation not found' }, status: :not_found
  end

  def create
    @reservation = Reservation.new(reservation_params)
    authorize! :create, @reservation
    authorize! :destroy, @reservation
    
    if @reservation.save
      render json: @reservation, status: :created
    else
      render json: { errors: @reservation.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @reservation = Reservation.find(params[:id])
    @reservation.destroy
    head :no_content
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Reservation not found' }, status: :not_found
  end

  private

  def reservation_params
    params.require(:reservation).permit(:city, :date, :user_id, :car_id)
  end
end
