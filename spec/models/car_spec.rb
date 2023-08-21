require 'rails_helper'

RSpec.describe Car, type: :model do
  let(:user) { User.create(username: 'testuser') }

  it 'is valid with valid attributes' do
    car = Car.new(
      car_model: 'Sedan',
      description: 'A comfortable sedan for daily use.',
      photo: 'sedan.jpg',
      reservation_price: 100.00,
      user:
    )
    expect(car).to be_valid
  end

  it 'is not valid without a car_model' do
    car = Car.new(
      car_model: nil,
      description: 'A comfortable sedan for daily use.',
      photo: 'sedan.jpg',
      reservation_price: 100.00,
      user:
    )
    expect(car).not_to be_valid
  end

  it 'is not valid without a description' do
    car = Car.new(
      car_model: 'Sedan',
      description: nil,
      photo: 'sedan.jpg',
      reservation_price: 100.00,
      user:
    )
    expect(car).not_to be_valid
  end

  it 'is not valid without a photo' do
    car = Car.new(
      car_model: 'Sedan',
      description: 'A comfortable sedan for daily use.',
      photo: nil,
      reservation_price: 100.00,
      user:
    )
    expect(car).not_to be_valid
  end

  it 'is not valid without a reservation_price' do
    car = Car.new(
      car_model: 'Sedan',
      description: 'A comfortable sedan for daily use.',
      photo: 'sedan.jpg',
      reservation_price: nil,
      user:
    )
    expect(car).not_to be_valid
  end

  it 'is not valid if reservation_price is not greater than 0' do
    car = Car.new(
      car_model: 'Sedan',
      description: 'A comfortable sedan for daily use.',
      photo: 'sedan.jpg',
      reservation_price: 0,
      user:
    )
    expect(car).not_to be_valid
  end
end
