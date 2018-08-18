Given(/^I run GnuPG with `(.*?)`$/) do |cli_options|
  cmd = "gpg --no-permission-warning --homedir #{TMP_PGP_HOME} #{cli_options}"
  run(cmd)
end
