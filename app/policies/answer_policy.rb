class AnswerPolicy < AdminPolicy
  def index?
    true
  end

  def show?
    return true if record.question.shared?
    return true if user.try(:has_role?, 'Librarian')
    return true if user and user == record.user
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
