# (c) Copyright 2018 Ribose Inc.
#

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
end
