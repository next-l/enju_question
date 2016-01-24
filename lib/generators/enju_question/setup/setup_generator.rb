class EnjuQuestion::SetupGenerator < Rails::Generators::Base
  source_root File.expand_path('../templates', __FILE__)

  def setup
    rake("enju_question_engine:install:migrations")
    inject_into_class "app/models/user.rb", User do
      <<"EOS"
  include EnjuQuestion::EnjuUser
EOS
    end
    inject_into_class "app/controllers/application.rb", User do
      <<"EOS"
  include EnjuQuestion::Controller
EOS
    end
    append_to_file("config/initializers/enju_leaf.rb" do
      <<"EOS"
Manifestation.include(EnjuQuestion::EnjuManifestation)
Item.include(EnjuQuestion::EnjuItem)
EOS
    end
  end
end
