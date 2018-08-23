# (c) Copyright 2018 Ribose Inc.
#

require "open3"
require "tempfile"

module RSpec
  module PGPMatchers
    module GPGMatcherHelper
      extend Forwardable

      def_delegators :"RSpec::PGPMatchers::GPGRunner", :run_verify, :run_decrypt

      def detect_signers(stderr_str)
        rx = /(?<ok>Good|BAD) signature from .*\<(?<email>[^>]+)\>/

        stderr_str.to_enum(:scan, rx).map do
          {
            email: $~["email"],
            ok: ($~["ok"] == "Good"),
          }
        end
      end

      def detect_recipients(stderr_str)
        rx = /encrypted with .*\n.*\<(?<email>[^>]+)\>/

        stderr_str.to_enum(:scan, rx).map do
          $~["email"]
        end
      end

      def match_cleartext(cleartext)
        if cleartext != expected_cleartext
          msg_mismatch(cleartext)
        end
      end

      def match_recipients(recipients)
        if expected_recipients.sort != recipients.sort
          msg_wrong_recipients(recipients)
        end
      end

      # Checks if signature is valid.  If `expected_signer` is not `nil`, then
      # it additionally checks if the signature was issued by expected signer.
      def match_signature(signature)
        if !signature[:ok]
          msg_mismatch(text)
        elsif expected_signer && signature[:email] != expected_signer
          msg_wrong_signer(signature[:email])
        end
      end
    end
  end
end
