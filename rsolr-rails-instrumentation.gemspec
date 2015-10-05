# encoding: utf-8

lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "rsolr/rails/instrumentation/version"

Gem::Specification.new do |spec|
  spec.name          = "rsolr-rails-instrumentation"
  spec.version       = Rsolr::Rails::Instrumentation::VERSION
  spec.authors       = ["kml"]
  spec.email         = ["kamil.lemanski@gmail.com"]

  spec.summary       = "RSolr instrumentation for Rails"
  spec.description   = "RSolr instrumentation for Rails"
  #spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.9"
  spec.add_development_dependency "rake", "~> 10.0"
end

