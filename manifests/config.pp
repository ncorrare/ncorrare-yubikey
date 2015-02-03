#The following class loads PAM. Variables have sane defaults. 
class yubikey::config ($arguments, $service, $control, $beforemod) {
  require ::yubikey::install
  if $::kernel =='Linux' {
    if $::osfamily == 'RedHat' and $::operatingsystem !~ /Fedora|Amazon/ {
      require ::pam
      #If we don't specify a service, default to system-auth
      if !($service) {
        $service = 'system-auth'
      }
      pam { 'Insert Yubikey entry on desired service':
        ensure    => present,
        service   => $yubikey::config::service,
        type      => 'auth',
        control   => $yubikey::config::control,
        module    => 'pam_yubico.so',
        arguments => $yubikey::config::arguments,
        position  => "before module ${beforemod}",
        }
      
    } elsif $::osfamily == 'RedHat' and $::operatingsystem =~ /Fedora/ {
      require ::pam
      #If we don't specify a service, default to system-auth
      if !($service) {
        $service = 'system-auth'
      }
      pam { 'Insert Yubikey entry on desired service':
        ensure    => present,
        service   => $yubikey::config::service,
        type      => 'auth',
        control   => $yubikey::config::control,
        module    => 'pam_yubico.so',
        arguments => $yubikey::config::arguments,
        position  => "before module ${beforemod}",
        }
 
    } elsif $::osfamily == 'Debian' and $::operatingsystem =~ /Ubuntu/ {
      require ::pam
      #If we don't specify a service, default to common-auth
      if !($service) {
        $service = 'common-auth'
      }
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
  } else {
    notice ("${::operatingsystem} is not supported")
  }
}
