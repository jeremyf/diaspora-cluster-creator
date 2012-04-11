# -*- encoding: utf-8 -*-
require File.expand_path('../lib/diaspora-cluster-creator/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Jeremy Friesen"]
  gem.email         = ["jeremy.n.friesen@gmail.com"]
  gem.description   = %q{Command-line utility to create Diaspora cluster}
  gem.summary       = %q{Command-line utility to create Diaspora cluster}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "diaspora-cluster-creator"
  gem.require_paths = ["lib"]
  gem.version       = Diaspora::Cluster::Creator::VERSION
  gem.add_development_dependency "cucumber"
  gem.add_development_dependency "bundler"
  gem.add_development_dependency "minitest"
  gem.add_development_dependency "guard"
  gem.add_development_dependency 'guard-minitest'
  gem.add_development_dependency 'guard-bundler'
  gem.add_development_dependency 'guard-cucumber'
  gem.add_development_dependency 'growl'
  
  gem.add_runtime_dependency "ruby-graphviz"
  gem.add_runtime_dependency "dependency_injector"
  gem.required_rubygems_version = ">= 1.8.7"
end
