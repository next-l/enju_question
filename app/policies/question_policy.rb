class QuestionPolicy < AdminPolicy
  def index?
    true
  end

  def show?
    if user.try(:has_role?, 'Librarian')
      true
    else
      if user and user == record.user
        true
      elsif record.shared
        true
      end
    end
  end

  def create?
    user.try(:has_role?, 'User')
  end

  def update?
    if user.try(:has_role?, 'Librarian')
      true
    else
      true if user and user == record.user
    end
  end

  def destroy?
    if user.try(:has_role?, 'Librarian')
      true
    else
      true if user and user == record.user
    end
  end
end
