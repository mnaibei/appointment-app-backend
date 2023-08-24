FactoryBot.define do
  factory :reservation do
    city { 'Sample City' }
    date { Date.today } # You can adjust the default date as needed
    association :user, factory: :user
    association :car, factory: :car
  end
end
