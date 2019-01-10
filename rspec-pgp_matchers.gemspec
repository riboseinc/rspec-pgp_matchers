# (c) Copyright 2018 Ribose Inc.
#

lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "rspec/pgp_matchers/version"

Gem::Specification.new do |spec|
  spec.name          = "rspec-pgp_matchers"
  spec.version       = RSpec::PGPMatchers::VERSION
  spec.authors       = ["Ribose Inc."]
  spec.email         = ["open.source@ribose.com"]

  spec.summary       = "RSpec matchers for testing OpenPGP messages"
  spec.homepage      = "https://github.com/riboseinc/rspec-pgp_matchers"
  spec.license       = "MIT"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added
  # into git.
  spec.files         = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject do |f|
      f.match(%r{^(test|spec|features)/})
    end
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "rspec-expectations", "~> 3.4"

  spec.add_development_dependency "bundler", ">= 1.16"
  spec.add_development_dependency "gpgme"
  spec.add_development_dependency "pry", ">= 0.10.3", "< 0.12"
  spec.add_development_dependency "rake", "~> 12.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
