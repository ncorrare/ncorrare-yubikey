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
        service   => $service,
        type      => 'auth',
        control   => $control,
        module    => 'pam_yubico.so',
        arguments => $arguments,
        position  => "before *[type=\"auth\" and module=\"${beforemod}\"]",
        }
      
  } else {
    notice ("${::operatingsystem} is not supported")
  }
}
