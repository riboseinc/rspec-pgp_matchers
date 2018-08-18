Given(/^I run GnuPG with (`.*?`)$/) do |cli_options|
  steps "I run `gpg --homedir #{TMP_PGP_HOME} #{cli_options}`"
end
