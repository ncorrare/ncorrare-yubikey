# == Class: yubikey
#
# The module installs the yubico PAM libraries that enable using yubikeys as a supported authentication method. 
# Using the default variables it will enable system wide yubikey authentication for all users defined using the yubikey::key type. 
# It assumes a default PAM configuration, but for complex environments the setup can be adjusted.
#
# === Parameters
#
# The ::yubikey class accepts all parameters for ::yubikey::install and ::yubikey::config.
#
# The ::yubikey::install accepts the following variables:
#  * $pkgname: String. Defaults to sane values in both RedHat and Debian derivatives.
#  * $managedeps: Bool. If set to true it will configure EPEL, or APT, if required.
#
# The ::yubikey::config class accepts the following variables:
#
#  * $arguments: Array. Defaults to ['debug','id=16']. Arguments are documented
#  in https://developers.yubico.com/yubico-pam/ .
#  * $service: Array. Defaults to system-auth & password-auth in RedHat systems
#  and common-auth in Ubuntu systems.
#  Depending on your implementation, you might want to have yubikey authentication on a
#  particular service (like sshd) so check your distribution documentation on how PAM
#  is configured for your system.
#  * $control: String. Defaults to 'sufficient'. Again, depending on your setup, you may want to add
#  other authentication controls. Refer to the PAM documentation. Module will accept requisite,
#  required, sufficient or optional.
#  * $beforemod: String. Defaults to 'pam_unix.so'. Works with most default PAM setups.
#
# The ::yubikey::key type accepts the following parameters:
#  * $token: String (12 char). Your Yubikey ID.
#  * $home: String. User home directory.
#  * $gid: String. User's primary group.
#
# === Examples
#
#  class { 'yubikey':
#    arguments => [ 'id=16' ],
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
  $arguments  = $yubikey::params::arguments,
  $service    = $yubikey::params::service,
  $control    = $yubikey::params::control,
  $beforemod  = $yubikey::params::beforemod,
  $pkgname    = $yubikey::params::pkgname,
  $managedeps = $yubikey::params::managedeps,
) inherits yubikey::params {
  validate_re($control, $yubikey::params::validcontrol)
  validate_array($arguments)
  validate_array($service)
  validate_string($beforemod)
  validate_string($pkgname)
  validate_bool($managedeps)
  class { '::yubikey::install':
    pkgname    => $pkgname,
    managedeps => $managedeps,
  }
  class { '::yubikey::config':
    arguments => $arguments,
    service   => $service,
    control   => $control,
    beforemod => $beforemod,
  }
}
