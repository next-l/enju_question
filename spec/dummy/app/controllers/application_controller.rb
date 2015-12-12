class ApplicationController < ActionController::Base
  protect_from_forgery
  include EnjuLeaf::Controller
  include EnjuBiblio::Controller
  include EnjuLibrary::Controller
  enju_question
  after_action :verify_authorized

  include Pundit
end
