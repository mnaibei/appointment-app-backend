FactoryBot.define do
    factory :reservation do
      city { 'Example City' }
      date { Time.now + 1.day } # Example date (adjust as needed)
      user
    end
  end
  