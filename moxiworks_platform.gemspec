# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'moxiworks_platform/version'

Gem::Specification.new do |spec|
  spec.name          = "moxiworks_platform"
  spec.version       = MoxiworksPlatform::VERSION
  spec.authors       = ["Tres Wong-Godfrey"]
  spec.email         = ["tres.wong-godfrey@moxiworks.com"]

  spec.summary       = %q{Ruby Moxi Works Platform Client}
  spec.homepage      = 'https://github.io/moxiworks-platform/moxiworks-ruby'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency 'rest-client'

end
