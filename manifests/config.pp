#The following class loads PAM. Variables have sane defaults. 
class yubikey::config (
  $arguments=$yubikey::params::arguments,
  $service=$yubikey::params::service,
  $control=$yubikey::params::control,
  $beforemod=$yubikey::params::beforemod,
) {
  require ::yubikey::install
  define addAuthYubico {
    pam { "Insert Yubikey entry on $name as $yubikey::config::control":
      ensure    => present,
      service   => $name,
      type      => 'auth',
      control   => $yubikey::config::control,
      module    => 'pam_yubico.so',
      arguments => $yubikey::config::arguments,
      position  => "before *[type=\"auth\" and module=\"${yubikey::config::beforemod}\"]",
      }
      #If debug is enabled, create a debug file"
   }
   if $::kernel =='Linux' and ($::osfamily == 'RedHat' or $::osfamily == 'Debian') {
     if 'debug' in $arguments {
       file { "/var/run/pam-debug.log" :
        ensure => present,
        mode => '0777'
      }
    }
    addAuthYubico { $service: } 
  } else {
    notice ("${::operatingsystem} is not supported")
  }
}
