# class Car < ApplicationRecord
#   belongs_to :user
#   has_many :reservations, dependent: :destroy

#   validates :car_model, :description, :photo, presence: true
#   validates :reservation_price, numericality: { greater_than: 0 }
# end
