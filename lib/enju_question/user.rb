module EnjuQuestion
  module QuestionUser
    def self.included(base)
      base.extend ClassMethods
    end

    module ClassMethods
      def enju_question_user_model
        include InstanceMethods
        has_many :questions
        has_many :answers
      end
    end

    module InstanceMethods
      def reset_answer_feed_token
        self.answer_feed_token = Devise.friendly_token
      end

      def delete_answer_feed_token
        self.answer_feed_token = nil
      end
    end
  end
end
