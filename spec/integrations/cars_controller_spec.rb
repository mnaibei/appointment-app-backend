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


end
end