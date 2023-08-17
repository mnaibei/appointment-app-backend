# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
# db/seeds.rb

# Create Users
User.create(username: 'user1')
User.create(username: 'user2')
User.create(username: 'user3')

# Create Cars
Car.create(
  car_model: 'Sedan',
  description: 'A comfortable sedan for daily use.',
  photo: 'sedan.jpg',
  reservation_price: 100.00,
  user_id: 1
)

Car.create(
  car_model: 'SUV',
  description: 'A spacious SUV for family trips.',
  photo: 'suv.jpg',
  reservation_price: 150.00,
  user_id: 2
)

# Create Reservations
Reservation.create(
  city: 'New York',
  date: Date.today + 7,
  user_id: 1,
  car_id: 1
)

Reservation.create(
  city: 'Los Angeles',
  date: Date.today + 10,
  user_id: 2,
  car_id: 2
)
