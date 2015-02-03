# == Class: yubikey
#
# Full description of class yubikey here.
#
# === Parameters
#
# Document parameters here.
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# === Variables
#
# None that I can think of.
#
# === Examples
#
#  class { 'yubikey':
#    servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#  }
#
# === Authors
#
# Nicolas Corrarello <ncorrare@gmail.com>
#
# === Copyright
#
# Copyright 2015 Nicolas Corrarello, unless otherwise noted.
#
class yubikey (
  $arguments='id=16 debug',
  $service,
  $control='sufficient',
  $beforemod='pam_unix.so',
)
  {
  class { '::yubikey::install' :} ->
  class { '::yubikey::config':
  arguments   => $arguments,
  service     => $service,
  control     => $control,
  beforemod   => $beforemod,
  }


}
