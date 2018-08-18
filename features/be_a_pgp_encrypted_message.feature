Feature: be_a_pgp_encrypted_message matcher

  Scenario: Testing if PGP message can be decrypted
    Given a file named "matcher_spec.rb" with:
      """ruby
      describe File.read("beard.txt.gpg") do
        it { is_expected.to be_a_pgp_encrypted_message }
      end
      """
    And I use a fixture named "limericks"
    And I run GnuPG with `--output beard.txt.gpg --encrypt --recipient Cato beard.txt`
    When I run `rspec matcher_spec.rb`
    Then the output should contain "1 example, 0 failures"
