# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "sunspot_massive_record/version"

Gem::Specification.new do |s|
  s.name        = "sunspot_massive_record"
  s.version     = SunspotMassiveRecord::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Companybook"]
  s.email       = ["geeks@companybook.no"]
  s.homepage    = %q{http://github.com/CompanyBook/sunspot_massive_record}
  s.summary     = %q{Sunspot adapter for MassiveRecord}
  s.description = %q{Sunspot adapter for MassiveRecord}

  s.rubyforge_project = "sunspot_massive_record"

  s.add_dependency "massive_record", ">= 0.0.1"
  s.add_dependency "sunspot_rails"
  s.add_dependency "activesupport"

  s.add_development_dependency "rspec", ">= 2.1.0"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
