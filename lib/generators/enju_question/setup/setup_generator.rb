class EnjuQuestion::SetupGenerator < Rails::Generators::Base
  source_root File.expand_path('../templates', __FILE__)

  def setup
    rake("enju_question_engine:install:migrations")
    inject_into_file 'app/models/user.rb',
      "  enju_question_user_model\n", :after => "enju_leaf_user_model\n"
  end
end
