# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ruby_gs/version'

Gem::Specification.new do |spec|
  spec.name          = "ruby_gs"
  spec.version       = RubyGS::VERSION
  spec.authors       = ["Conrad King"]
  spec.email         = ["rainbowryke@gmail.com"]

  spec.summary       = %q{Allows viewing and editing of Pokemon G/S/C save files.}
  spec.description   = %q{RubyGS is a Ruby Gem that provides a simple interface to view and edit the data inside of a save file for the Gameboy Color games Pokemon Gold, Silver, and Crystal versions.}
  spec.homepage      = "https://github.com/RainbowReich/ruby_gs"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "bindata", "~> 2.1.0"

  spec.add_development_dependency "bundler", "~> 1.8"
  spec.add_development_dependency "rake", "~> 10.0"
end
