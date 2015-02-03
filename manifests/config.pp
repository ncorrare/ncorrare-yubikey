#The following class loads PAM. Variables have sane defaults. 
class yubikey::config (
  $arguments=$yubikey::params::arguments,
  $service=$yubikey::params::service,
  $control=$yubikey::params::control,
  $beforemod=$yubikey::params::beforemod
) {
  require ::yubikey::install
  if $::kernel =='Linux' {
      pam { 'Insert Yubikey entry on desired service':
        ensure    => present,
        service   => $yubikey::config::service,
        type      => 'auth',
        control   => $yubikey::config::control,
        module    => 'pam_yubico.so',
        arguments => $yubikey::config::arguments,
        position  => "before module ${beforemod}",
        }
      
  } else {
    notice ("${::operatingsystem} is not supported")
  }
}
