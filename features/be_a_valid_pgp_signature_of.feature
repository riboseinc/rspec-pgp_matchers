Feature: be_a_valid_pgp_signature_of matcher

  Background:
    Given I use a fixture named "limericks"

  Scenario: Testing if signature has been issued for given text
    Given a file named "matcher_spec.rb" with:
      """ruby
      require "rspec/pgp_matchers"

      describe File.read("signature") do
        let(:beard) { File.read "beard.txt" }
        let(:nice) { File.read "nice.txt" }

        it { is_expected.to be_a_valid_pgp_signature_of(beard) }
        it { is_expected.not_to be_a_valid_pgp_signature_of(nice) }
      end
      """
    When I run GnuPG with `--armor --output signature --detach-sign beard.txt`
    And I run `rspec matcher_spec.rb`
    Then the output should contain "2 examples, 0 failures"
