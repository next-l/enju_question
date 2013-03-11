require "enju_question/engine"
require "enju_question/user"
require "enju_question/manifestation"
require "enju_question/item"

module EnjuQuestion
  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods
    def enju_question
      include EnjuQuestion::InstanceMethods
    end
  end

  module InstanceMethods
    private

    def get_question
      @question = Question.find(params[:question_id]) if params[:question_id]
      authorize! :show, @question if @question
    end
  end
end

ActionController::Base.send(:include, EnjuQuestion)
ActiveRecord::Base.send :include, EnjuQuestion::QuestionUser
ActiveRecord::Base.send :include, EnjuQuestion::QuestionManifestation
ActiveRecord::Base.send :include, EnjuQuestion::QuestionItem
