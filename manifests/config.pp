#The following class loads PAM. Variables have sane defaults. 
class yubikey::config (
  $arguments=$yubikey::params::arguments,
  $service=$yubikey::params::service,
  $control=$yubikey::params::control,
  $beforemod=$yubikey::params::beforemod
) {
  require ::yubikey::install
  define addAuthYubico {
    pam { 'Insert Yubikey entry on desired service':
      ensure    => present,
      service   => $name,
      type      => 'auth',
      control   => $control,
      module    => 'pam_yubico.so',
      arguments => $arguments,
      position  => "before *[type=\"auth\" and module=\"${beforemod}\"]",
      }
      #If debug is enabled, create a debug file"
      if 'debug' in $arguments {
        file { "/var/run/pam-debug.log" :
          ensure => present,
          mode => '0777'
        }
      }
    }
   if $::kernel =='Linux'  {
    addAuthYubico { $service: }
      
  } else {
    notice ("${::operatingsystem} is not supported")
  }
}
