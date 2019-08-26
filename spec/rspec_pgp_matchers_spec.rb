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
    gpg_path_preserve = RSpec::PGPMatchers.gpg_path
    expect { RSpec::PGPMatchers.gpg_path = "some/path" }.
      to change { RSpec::PGPMatchers.gpg_path }.to("some/path")
    RSpec::PGPMatchers.gpg_path = gpg_path_preserve
  end

  it "has a default value for gpg_path" do
    expect(RSpec::PGPMatchers.gpg_path).to eq("gpg")
  end
end
