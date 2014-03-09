class QuestionPolicy < AdminPolicy
  def show?
    if user.try(:has_role?, 'Librarian')
      true
    else
      true if user and user == record.user
    end
  end

  def create?
    user.try(:has_role?, 'Librarian')
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
