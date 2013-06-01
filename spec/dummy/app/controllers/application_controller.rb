class ApplicationController < ActionController::Base
  protect_from_forgery

  enju_leaf
  enju_library
  enju_question
end
