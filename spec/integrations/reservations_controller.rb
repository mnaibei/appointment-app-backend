require 'rails_helper'

RSpec.describe 'Reservations', type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:car) { FactoryBot.create(:car, user:) }
  let(:reservation) { FactoryBot.create(:reservation, car_id: car.id, user_id: user.id) }

  describe 'GET/index' do
    it 'returns http succes' do
      get "/users/#{user.id}/cars/#{car.id}/reservations"
      expect(response.status).to eq(200)
    end

    it 'returns http success and the reservation' do
      get "/users/#{user.id}/cars/#{car.id}/reservations/#{reservation.id}"

      expect(response).to have_http_status(:ok)
      returned_reservation = JSON.parse(response.body)
      expect(returned_reservation['id']).to eq(reservation.id)
    end

    it 'returns http not found and an error message' do
      user = User.create(username: 'John')
      car = Car.create(car_model: 'Toyota Camry', user:)
      non_existent_reservation_id = 12_345

      get "/users/#{user.id}/cars/#{car.id}/reservations/#{non_existent_reservation_id}"

      expect(response).to have_http_status(:not_found)
      error_response = JSON.parse(response.body)
      expect(error_response['error']).to eq('Reservation not found')
    end
  end

  describe 'DELETE #destroy' do
    it 'deletes a reservation' do
      delete "/users/#{user.id}/cars/#{car.id}/reservations/#{reservation.id}"
      expect(response).to have_http_status(:no_content)
    end
  end
end
