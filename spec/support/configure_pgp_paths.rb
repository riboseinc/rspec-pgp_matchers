# (c) Copyright 2018 Ribose Inc.
#

RSpec::PGPMatchers.homedir = TMP_PGP_HOME
GPGME::Engine.home_dir = TMP_PGP_HOME

# Forget constant to prove that tests and gem itself rely on
# RSpec::PGPMatchers.homedir instead.
Object.send :remove_const, :TMP_PGP_HOME
