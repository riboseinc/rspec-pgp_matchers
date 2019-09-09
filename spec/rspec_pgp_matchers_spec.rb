# (c) Copyright 2018 Ribose Inc.
#

require "spec_helper"

RSpec.describe RSpec::PGPMatchers do
  it "has a version number" do
    expect(RSpec::PGPMatchers::VERSION).not_to be nil
  end

  # This test would break others if run in parallel
  it "has configurable homedir" do
    homedir_preserve = RSpec::PGPMatchers.homedir
    expect { RSpec::PGPMatchers.homedir = "some/path" }.
      to change { RSpec::PGPMatchers.homedir }.to("some/path")
    RSpec::PGPMatchers.homedir = homedir_preserve
  end

  # This test would break others if run in parallel
  it "has configurable path to GPG executable" do
    gpg_executable_preserve = RSpec::PGPMatchers.gpg_executable
    expect { RSpec::PGPMatchers.gpg_executable = "some/path" }.
      to change { RSpec::PGPMatchers.gpg_executable }.to("some/path")
    RSpec::PGPMatchers.gpg_executable = gpg_executable_preserve
  end

  it "has a default value for gpg_executable" do
    expect(RSpec::PGPMatchers.gpg_executable).to eq("gpg")
  end
end
