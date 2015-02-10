#The following class loads PAM. Variables have sane defaults. 
class yubikey::config (
  $arguments=$yubikey::params::arguments,
  $service=$yubikey::params::service,
  $control=$yubikey::params::control,
  $beforemod=$yubikey::params::beforemod,
) inherits yubikey::params {
  require ::yubikey::install
  validate_re($control, $yubikey::params::validcontrol)
  validate_array($arguments)
  validate_array($service)
  validate_string($beforemod)
  if $::kernel =='Linux' and
  ($::osfamily == 'RedHat' or $::osfamily == 'Debian') {
    if 'debug' in $arguments {
      file { '/var/run/pam-debug.log' :
        ensure => present,
        mode   => '0777'
      }
    }
    yubikey::addauthyubico { $service :
    arguments => $arguments,
    control   => $control,
    beforemod => $beforemod,
    }

  } else {
    notice ("${::operatingsystem} is not supported")
  }
}
