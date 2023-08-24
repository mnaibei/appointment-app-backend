class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :api

  has_many :cars, dependent: :destroy
  has_many :reservations, dependent: :destroy

  validates :username, :role, :email, presence: true

  enum role: %i[user renter owner]
  # after_initialize :set_default_role, if: :new_record?
  # set default role to user  if not set
  # def set_default_role
  #   self.role ||= :user
  # end
end
