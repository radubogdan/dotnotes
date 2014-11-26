# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'dotnotes/version'

Gem::Specification.new do |spec|
  spec.name          = "dotnotes"
  spec.version       = Dotnotes::VERSION
  spec.authors       = ["Radu-Bogdan Croitoru"]
  spec.email         = ["croitoruradubogdan@gmail.com"]
  spec.summary       = %q{Create notes from your terminal.}
  spec.description   = %q{Simple CLI Application to create and edit notes directly from terminal.}
  spec.homepage      = "https://github.com/radubogdan/dotnotes"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
end
