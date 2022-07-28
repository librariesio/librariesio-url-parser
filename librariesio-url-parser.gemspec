# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "librariesio-url-parser"

Gem::Specification.new do |spec|
  spec.name          = "librariesio-url-parser"
  spec.version       = LibrariesioURLParser::VERSION
  spec.authors       = ["Matt Pace"]
  spec.email         = ["matt.pace@tidelift.com"]

  spec.summary       = "Parse the URL for various repositories tracked by libraries.io"
  spec.homepage      = "https://github.com/librariesio/librariesio-url-parser"
  spec.license       = "AGPL-3.0"
  spec.metadata = { "rubygems_mfa_required" => "true" }

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "rake", "~> 12.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "rspec_junit_formatter", "~> 0.5"
  spec.add_development_dependency "pry", "~> 0.14.1"
end
