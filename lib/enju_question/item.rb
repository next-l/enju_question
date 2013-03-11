module EnjuQuestion
  module QuestionItem
    def self.included(base)
      base.extend ClassMethods
    end

    module ClassMethods
      def enju_question_item_model
        has_many :answer_has_items, :dependent => :destroy
        has_many :answers, :through => :answer_has_items
      end
    end
  end
end
