require "enju_question/engine"

module EnjuQuestion
  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods
    def enju_question
      include EnjuLibrary::InstanceMethods
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

