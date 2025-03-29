class TicketPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.organizer?
        scope.joins(:event).where(events: { organizer_id: user.id })
        # An organizer can see only those tickets which belongs the event created by him/her 
      else
        raise Pundit::NotAuthorizedError
      end
    end
  end

  def show?
    user.organizer? && record.event.organizer_id == user.id
    # An organizer can aceess only those tickets which belongs the event created by him/her 
  end

  def create?
    user.organizer? && record.event.organizer_id == user.id
    # An organizer can aceess only those tickets which belongs the event created by him/her 
  end

  def update?
    user.organizer? && record.event.organizer_id == user.id
    # An organizer can aceess only those tickets which belongs the event created by him/her 
  end

  def destroy?
    user.organizer? && record.event.organizer_id == user.id
    # An organizer can aceess only those tickets which belongs the event created by him/her 
  end
end
