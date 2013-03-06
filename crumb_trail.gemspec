$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "crumb_trail/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "crumb_trail"
  s.version     = CrumbTrail::VERSION
  s.authors     = ["Michael de Silva"]
  s.email       = ["michael@omakaselabs.com"]
  s.homepage    = "http://omakaselabs.com"
  s.summary     = "Log all changes to your models' data.  This is Yet Another Acts_As_Loggable gem."
  s.description = s.summary

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "rails", "~> 3.2.12"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "mocha"
end
