FactoryBot.define do
  factory :car do
    car_model { 'Model S' }
    description { 'Electric car' }
    photo { 'image.jpg' }
    reservation_price { 200 }
    user
  end
end
