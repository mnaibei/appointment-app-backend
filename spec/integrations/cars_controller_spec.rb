require 'rails_helper'

RSpec.describe "CarsController", type: :request do
  let(:user) { User.create(username: 'testuser') }

  describe "GET /users/:user_id/cars" do
    it "returns a list of cars" do
      car1 = Car.create(
        car_model: "SUV",
        description: "A spacious SUV",
        photo: "suv.jpg",
        reservation_price: 150.00,
        user: user
      )
      car2 = Car.create(
        car_model: "Sedan",
        description: "A comfortable sedan",
        photo: "sedan.jpg",
        reservation_price: 100.00,
        user: user
      )

      get "/users/#{user.id}/cars"
      expect(response).to have_http_status(200)

      cars = JSON.parse(response.body)
      expect(cars.length).to eq(2)
    end

    it "returns an error if no cars are found" do
        get "/users/#{user.id}/cars"
        expect(response).to have_http_status(404)
  
        error_response = JSON.parse(response.body)
        expect(error_response["error"]).to eq("No cars found")
      end
    end

    describe "GET /users/:user_id/cars/:id" do
        it "returns a car by id" do
          car = Car.create(
            car_model: "SUV",
            description: "A spacious SUV",
            photo: "suv.jpg",
            reservation_price: 150.00,
            user: user
          )
    
          get "/users/#{user.id}/cars/#{car.id}"
          expect(response).to have_http_status(200)
    
          car_response = JSON.parse(response.body)
          expect(car_response["id"]).to eq(car.id)
        end
    
        it "returns an error if car is not found" do
          get "/users/#{user.id}/cars/999"
          expect(response).to have_http_status(404)
    
          error_response = JSON.parse(response.body)
          expect(error_response["error"]).to eq("No car found")
        end
      end

      describe "POST /users/:user_id/cars" do
        it "creates a new car" do
          car_params = {
            car_model: "SUV",
            description: "A spacious SUV",
            photo: "suv.jpg",
            reservation_price: 150.00
          }
    
          post "/users/#{user.id}/cars", params: car_params
          expect(response).to have_http_status(200)
    
          car_response = JSON.parse(response.body)
          expect(car_response["car_model"]).to eq("SUV")
        end
    
        it "returns an error if car creation fails" do
          post "/users/#{user.id}/cars", params: { car_model: "SUV" }
          expect(response).to have_http_status(400)
    
          error_response = JSON.parse(response.body)
          expect(error_response["error"]).to eq("Unable to save car")
        end
      end
end