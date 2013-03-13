#module EnjuQuestion
  class Ability
    include CanCan::Ability
  
    def initialize(user, ip_address = nil)
      case user.try(:role).try(:name)
      when 'Administrator'
        can :manage, Answer
        can :manage, Question
      when 'Librarian'
        can :manage, Answer
        can :manage, Question
      when 'User'
        can [:index, :create], Answer
        can :show, Answer do |answer|
          if answer.user == user
            true
          elsif answer.question.shared
            true
          end
        end
        can [:update, :destroy, :delete], Answer do |answer|
          answer.user == user
        end
        can [:index, :create], Question
        can [:update, :destroy, :delete], Question do |question|
          question.user == user
        end
        can :show, Question do |question|
          question.user == user or question.shared
        end
      else
        can :index, Answer
        can :show, Answer do |answer|
          answer.question.shared
        end
        can :index, Question
        can :show, Question do |question|
          question.shared
        end
      end
    end
  end
#end
