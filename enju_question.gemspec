$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "enju_question/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "enju_question"
  s.version     = EnjuQuestion::VERSION
  s.authors     = ["Kosuke Tanabe"]
  s.email       = ["tanabe@mwr.mediacom.keio.ac.jp"]
  s.homepage    = "https://github.com/nabeta/enju_question.git"
  s.summary     = "enju_queestion plugin"
  s.description = "Question and answer management for Next-L Enju"

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["spec/**/*"]

  s.add_dependency "rails", "~> 3.2"
  s.add_dependency "simple_form"
  s.add_dependency "sunspot_rails"
  s.add_dependency "sunspot_solr"
  s.add_dependency "devise"
  s.add_dependency "cancan"
  s.add_dependency "acts-as-taggable-on", "~> 2.2"
  s.add_dependency "friendly_id", "~> 4.0"
  s.add_dependency "nokogiri"
  s.add_dependency "will_paginate", "~> 3.0"
  s.add_dependency "acts_as_list", "~> 0.1.6"
  s.add_dependency "enju_ndl", "~> 0.0.33"
  s.add_dependency "enju_core"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "factory_girl_rails"
  s.add_development_dependency "vcr", "~> 2.2"
  s.add_development_dependency "fakeweb"
  s.add_development_dependency "enju_biblio"
  s.add_development_dependency "enju_manifestation_viewer"
end
