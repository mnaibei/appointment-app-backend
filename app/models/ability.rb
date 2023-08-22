class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    can :read, Car

    if user.owner?
      can %i[create update destroy], Car

      cannot :create, Reservation
    end

    return unless user.renter?

    can %i[create update destroy], Reservation

    cannot :create, Car
  end
end
