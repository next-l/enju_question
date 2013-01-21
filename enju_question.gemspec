$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "enju_question/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "enju_question"
  s.version     = EnjuQuestion::VERSION
  s.authors     = ["Kosuke Tanabe"]
  s.email       = ["tanabe@mwr.mediacom.keio.ac.jp"]
  s.homepage    = "https://github.com/next-l/enju_question"
  s.summary     = "enju_queestion plugin"
  s.description = "Question and answer management for Next-L Enju"

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["spec/**/*"]

  s.add_dependency "rails", "~> 3.2"
  s.add_dependency "simple_form"
  s.add_dependency "acts-as-taggable-on", "~> 2.3"
  s.add_dependency "enju_core", "~> 0.1.1.pre2"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "factory_girl_rails"
  s.add_development_dependency "vcr", "~> 2.4"
  s.add_development_dependency "fakeweb"
  s.add_development_dependency "enju_biblio", "~> 0.1.0.pre13"
  s.add_development_dependency "enju_ndl", "~> 0.1.0.pre8"
  s.add_development_dependency "enju_manifestation_viewer", "~> 0.1.0.pre3"
  s.add_development_dependency "sunspot_solr", "~> 2.0.0.pre.130115"
end
