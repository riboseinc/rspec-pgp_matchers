# (c) Copyright 2018 Ribose Inc.
#

require "spec_helper"

RSpec.describe RSpec::PGPMatchers::GPGRunner do
  let(:failure_exception) { RSpec::Expectations::ExpectationNotMetError }
  let(:crypto) { ::GPGME::Crypto.new(crypto_opts) }
  let(:text) { "text" }
  let(:misspelled) { "teXt" }
  let(:recipient) { "whatever@example.test" }
  let(:signer) { "whatever@example.test" }

  let(:crypto_opts) do
    { armor: true, recipients: [recipient], signers: signer, sign: true }
  end

  before do
    allow(described_class).to receive(:run_command).and_call_original
  end

  describe "#run_command" do
    subject { described_class.method :run_command }

    it "runs arbitrary GnuPG commands, and returns their captured standard " +
      "output, error, and exit status" do
      retval = subject.("--list-keys")
      expect(retval[0]).to be_a(String) & match(/pubring/) & match(/Cato/)
      expect(retval[1]).to be_a(String)
      expect(retval[2]).to be_a(Process::Status) & be_success
    end

    it "calls the executable specified by RSpec::PGPMatchers.gpg_executable" do
      allow(RSpec::PGPMatchers).to receive(:gpg_executable).
        and_return("path/to/gpg")
      allow(Open3).to receive(:capture3).with(anything, %r[^path/to/gpg])
      subject.("--some-command")
    end

    it "calls the executable specified by RSpec::PGPMatchers.homedir" do
      allow(RSpec::PGPMatchers).to receive(:homedir).and_return("path/to/home")
      allow(Open3).to receive(:capture3).
        with(anything, %r[--homedir path/to/home])
      subject.("--some-command")
    end
  end

  describe "#run_decrypt" do
    subject { described_class.method :run_decrypt }

    let(:enc) { crypto.encrypt(text).to_s }

    it "runs GnuPG decrypt command, and returns captured standard " +
      "output, error, and exit status" do
      retval = subject.(enc)
      expect(described_class).to have_received(:run_command).
        with(/^--decrypt\b/)
      expect(retval[0]).to be_a(String) & eq(text)
      expect(retval[1]).to be_a(String) & match(/^gpg: encrypted/)
      expect(retval[2]).to be_a(Process::Status) & be_success
    end
  end

  describe "#run_verify" do
    subject { described_class.method :run_verify }

    let(:sig) { crypto.detach_sign(text).to_s }

    it "runs GnuPG decrypt command, and returns captured standard " +
      "output, error, and exit status" do
      retval = subject.(text, sig)
      expect(described_class).to have_received(:run_command).
        with(/^--verify\b/)
      expect(retval[0]).to be_a(String)
      expect(retval[1]).to be_a(String) & match(/^gpg: Good signature/)
      expect(retval[2]).to be_a(Process::Status) & be_success
    end
  end
end
