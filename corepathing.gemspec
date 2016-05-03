# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'corepathing/version'

Gem::Specification.new do |spec|
  spec.name          = "corepathing"
  spec.version       = Corepathing::VERSION
  spec.authors       = ["Matt Williams"]
  spec.email         = ["mdubbs@gmail.com"]

  spec.summary       = %q{Curriculum pathing}
  spec.description   = %q{Common core domain learning path generation based on standardized test scores}
  spec.homepage      = "https://github.com/mdubbs/corepathing"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
