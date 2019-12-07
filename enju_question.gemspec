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

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.md"]
  s.test_files = Dir["spec/**/*"] - Dir["spec/dummy/db/*.sqlite3"] - Dir["spec/dummy/log/*"] - Dir["spec/dummy/solr/**/*"] - Dir["spec/dummy/tmp/*"]

  s.add_dependency "enju_bookmark", "~> 0.4.0.rc.1"

  s.add_development_dependency "enju_leaf", "~> 2.0.0.rc.1"
  s.add_development_dependency "enju_ndl", "~> 0.4.0.rc.1"
  s.add_development_dependency "pg"
  s.add_development_dependency "rspec-rails", "~> 3.9"
  s.add_development_dependency "factory_bot_rails"
  s.add_development_dependency "vcr", "~> 5.0"
  s.add_development_dependency "sunspot_solr", "~> 2.5"
  s.add_development_dependency "webmock"
  s.add_development_dependency "simplecov"
  s.add_development_dependency "annotate"
  s.add_development_dependency "coveralls"
  s.add_development_dependency "sprockets", "~> 3.7"
end
