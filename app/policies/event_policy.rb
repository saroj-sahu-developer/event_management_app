class EventPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      if user.organizer?
        scope.where(organizer_id: user.id) # Organizers see only their events
      elsif user.customer?
        scope.all # Customers see all events
      else
        raise Pundit::NotAuthorizedError 
      end
    end
  end

  def create?
    user.organizer? && record.organizer_id == user.id
  end

  def update?
    user.organizer? && record.organizer_id == user.id
  end

  def destroy?
    user.organizer? && record.organizer_id == user.id
  end
end