# (c) Copyright 2018 Ribose Inc.
#

require "rspec/expectations"
require "rspec/pgp_matchers/version"
require "rspec/pgp_matchers/gpg_matcher_helper"
require "rspec/pgp_matchers/gpg_runner"
require "rspec/pgp_matchers/be_a_pgp_encrypted_message"
require "rspec/pgp_matchers/be_a_valid_pgp_signature_of"

module RSpec
  module PGPMatchers
    @gpg_executable = "gpg"

    class << self
      # Name of the GnuPG executable or path to that executable.  Defaults to
      # +gpg+.
      #
      # Absolute and relative paths are allowed, but usually setting +$PATH+
      # environment variable is a better idea.
      #
      # @return [String] executable name or absolute or relative path to that
      #   executable
      attr_accessor :gpg_executable

      # Path to the OpenPGP home directory.  Defaults to +nil+ and must be set
      # prior using the matchers.
      #
      # Given directory may be initialized with other tool than GnuPG, e.g. RNP,
      # but it must be in a format which is readable by GnuPG.  Also,
      # if specified directory is empty, then it will be initialized by GnuPG
      # at first use, it must exist though.  Nevertheless, the latter case is
      # not very practical, as the OpenPGP home directory created this way
      # contains no keys.
      #
      # It is recommended to have a dedicated PGP home directory just for
      # testing, so that test keys are separated from regular ones.
      #
      # @return [String] absolute or relative path to the OpenPGP home directory
      attr_accessor :homedir
    end
  end
end
