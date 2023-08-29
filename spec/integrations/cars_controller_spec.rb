require 'rails_helper'

RSpec.describe CarsController, type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:car) { FactoryBot.create(:car, user:) }

  # puts "user: #{user.inspect}"
  describe 'GET #index' do
    it 'returns a list of cars' do
      puts "car: #{car.inspect}"
      get '/cars'
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)).not_to be_empty
    end

    it 'returns an error if no cars are found' do
      Car.destroy_all
      get "/users/#{user.id}/cars"
      expect(response).to have_http_status(:not_found)
      expect(JSON.parse(response.body)).to eq({ 'error' => 'No cars found' })
    end
  end

  describe 'GET #show' do
    it 'returns a car' do
      get "/users/#{user.id}/cars/#{car.id}"
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)['id']).to eq(car.id)
    end
  end

  describe 'POST #create' do
    let(:valid_attributes) do
      { car_model: 'Model X', description: 'Electric car', photo: 'image.jpg', reservation_price: 100 }
    end
    let(:invalid_attributes) { { car_model: '', description: 'Electric car', reservation_price: 100 } }

    it 'creates a new car with valid attributes' do
      post "/users/#{user.id}/cars", params: valid_attributes
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)['car_model']).to eq('Model X')
    end

    it 'returns an error with invalid attributes' do
      post "/users/#{user.id}/cars", params: invalid_attributes
      expect(response).to have_http_status(:bad_request)
      expect(JSON.parse(response.body)).to eq({ 'error' => 'Unable to save car' })
    end
  end

  describe 'DELETE #destroy' do
    it 'deletes a car' do
      delete "/users/#{user.id}/cars/#{car.id}"
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)['id']).to eq(car.id)
    end
  end
end
