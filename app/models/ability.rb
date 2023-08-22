class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    can :read, Car

    if user.owner?
      can %i[create destroy], Car

      cannot :create, Reservation
    end

    return unless user.renter?

    can %i[create destroy], Reservation

    cannot :create, Car
  end
end
