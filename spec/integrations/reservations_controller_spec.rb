require 'rails_helper'

Rspec.describe "Reservations", type: :request do
    describe "GET /index" do
        it "returns all reservations" do
            get "/users/#{user.id}/cars/#{car.id}/reservations"
            expect(response).to have_http_status(:ok)
            expect(JSON.parse(response.body)).not_to be_empty
        end
    end
end