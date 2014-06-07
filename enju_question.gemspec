$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "enju_question/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "enju_question"
  s.version     = EnjuQuestion::VERSION
  s.authors     = ["Kosuke Tanabe"]
  s.email       = ["nabeta@fastmail.fm"]
  s.homepage    = "https://github.com/next-l/enju_question"
  s.summary     = "enju_queestion plugin"
  s.description = "Question and answer management for Next-L Enju"

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["spec/**/*"] - Dir["spec/dummy/log/*"] - Dir["spec/dummy/solr/{data,pids}/*"]

  s.add_dependency "enju_seed", "~> 0.1.1.pre9"
  s.add_dependency "simple_form"
  s.add_dependency "acts-as-taggable-on", "~> 3.2"
  s.add_dependency "rails_autolink"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "rspec-rails", "2.99"
  s.add_development_dependency "factory_girl_rails"
  s.add_development_dependency "vcr", "~> 2.8"
  s.add_development_dependency "enju_leaf", "~> 1.1.0.rc9"
  s.add_development_dependency "enju_ndl", "~> 0.1.0.pre31"
  s.add_development_dependency "sunspot_solr", "~> 2.1"
  s.add_development_dependency "fakeweb"
  s.add_development_dependency "sunspot-rails-tester"
end
