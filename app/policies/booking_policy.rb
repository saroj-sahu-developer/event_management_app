class BookingPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.customer?
        scope.where(customer_id: user.id) # Customers can see only their bookings
      elsif user.organizer?
        scope.all  # Organizers can see all bookings
      else
        raise Pundit::NotAuthorizedError
      end
    end
  end

  def show?
    user.customer? && record.customer_id == user.id
  end

  def create?
    user.customer?
  end

  def destroy?
    user.customer? && record.customer_id == user.id
  end
end
