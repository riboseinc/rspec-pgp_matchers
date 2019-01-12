# (c) Copyright 2018 Ribose Inc.
#

require "open3"
require "tempfile"

module RSpec
  module PGPMatchers
    module GPGRunner
      class << self
        def run_command(gpg_cmd)
          env = { "LC_ALL" => "C" } # Gettext English locale

          homedir_path = Shellwords.escape(RSpec::PGPMatchers.homedir)

          Open3.capture3(env, <<~SH)
            gpg \
            --homedir #{homedir_path} \
            --no-permission-warning \
            #{gpg_cmd}
          SH
        end

        def run_decrypt(encrypted_string)
          enc_file = make_tempfile_containing(encrypted_string)
          cmd = gpg_decrypt_command(enc_file)
          run_command(cmd)
        ensure
          File.unlink(enc_file.path)
        end

        def run_verify(cleartext, signature_string)
          sig_file = make_tempfile_containing(signature_string)
          data_file = make_tempfile_containing(cleartext)
          cmd = gpg_verify_command(sig_file, data_file)
          run_command(cmd)
        ensure
          File.unlink(sig_file.path, data_file.path)
        end

        private

        def make_tempfile_containing(file_content)
          # Tempfile.new instantiates Tempfile objects, and handles file
          # deletion in various situations (i.e. object's finalizer), whereas
          # Tempfile.create instantiates File objects, and leaves file deletion
          # up to programmer.
          #
          # Tempfile's surprise file removals were among causes of race
          # conditions, so let's go with the create method.
          tempfile = Tempfile.create("rspec-gpg-runner")
          tempfile.write(file_content)
          tempfile.close
          tempfile
        end

        def gpg_decrypt_command(enc_file)
          enc_path = Shellwords.escape(enc_file.path)
          "--decrypt #{enc_path}"
        end

        def gpg_verify_command(sig_file, data_file)
          sig_path = Shellwords.escape(sig_file.path)
          data_path = Shellwords.escape(data_file.path)
          "--verify #{sig_path} #{data_path}"
        end
      end
    end
  end
end
