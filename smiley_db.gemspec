# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = "smiley_db"
  spec.version       = '0.0.1'
  spec.authors       = ["Daniel P. Clark"]
  spec.email         = ["6ftdan@gmail.com"]

  spec.summary       = %q{CLI ASCII smiley DB.}
  spec.description   = %q{CLI ASCII smiley database.}
  spec.license       = "MIT"
  spec.files         = ['bin/smiley_db', 'LICENSE']
  spec.bindir        = "bin"
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.12"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_dependency "activerecord", "~> 4.2"
  spec.add_dependency "highline", "~> 1.7"
end
