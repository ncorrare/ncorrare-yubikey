class yubikey::config ($arguments='id=16 debug', $service, $control='sufficient', $before='pam_unix.so') {
  require ::yubikey::install
  if $::kernel =='Linux' {
    if $::osfamily == 'RedHat' and $::operatingsystem !~ /Fedora|Amazon/ {
      #Insert Red Hat / Centos PAM Logic
      require ::pam
      #If we don't specify a service, default to system-auth
      if !($service) {
        $service = 'system-auth'
      }
      pam { 'Insert Yubikey entry on system-auth':
        ensure => present,
        service => $yubikey::config::service,
        type => 'auth',
        control => $yubikey::config::control,
        module => 'pam_yubico.so',
        arguments => $yubikey::config::arguments,
        position => "before module $before",
        }
      
    } elsif $::osfamily == 'RedHat' and $::operatingsystem =~ /Fedora/ {
      #Insert Fedora Logic
    } elsif $::osfamily == 'Debian' and $::operatingsystem =~ /Ubuntu/ {
      #Insert Ubuntu Logic
    } else {
      notice ("${::operatingsystem} is not supported")
    }
  } else {
    notice ("${::operatingsystem} is not supported")
  }
}
