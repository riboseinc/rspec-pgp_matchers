# (c) Copyright 2018 Ribose Inc.
#

require "rspec/pgp_matchers/version"
require "rspec/pgp_matchers/gpg_matcher_helper"
require "rspec/pgp_matchers/gpg_runner"
require "rspec/pgp_matchers/be_a_pgp_encrypted_message"
require "rspec/pgp_matchers/be_a_valid_pgp_signature_of"

module RSpec
  module PGPMatchers
    @gpg_executable = "gpg"

    class << self
      attr_accessor :gpg_executable
      attr_accessor :homedir
    end
    # Your code goes here...
  end
end
