# (c) Copyright 2018 Ribose Inc.
#

require "spec_helper"

RSpec.describe :be_a_valid_pgp_signature_of do
  subject { method(:be_a_valid_pgp_signature_of) }
  let(:failure_exception) { RSpec::Expectations::ExpectationNotMetError }
  let(:crypto) { ::GPGME::Crypto.new(armor: true, signer: signer) }
  let(:sig) { crypto.detach_sign(text).to_s }
  let(:text) { "text" }
  let(:misspelled) { "teXt" }
  let(:signer) { "whatever@example.test" }

  it "assures that string contains PGP data" do
    m = subject.(text)
    expect(m.matches?("a ")).to be(false)
  end

  it "assures that string is a valid signature of given text" do
    m = subject.(text)
    expect(m.matches?(sig)).to be(true)

    m = subject.(misspelled)
    expect(m.matches?(sig)).to be(false)
  end

  it "assures that string is signed with correct key" do
    m = subject.(text).signed_by(signer)
    expect(m.matches?(sig)).to be(true)

    m = subject.(text).signed_by("a@example.test")
    expect(m.matches?(sig)).to be(false)

    m = subject.(misspelled).signed_by(signer)
    expect(m.matches?(sig)).to be(false)
  end
end
