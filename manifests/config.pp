class yubikey::config ($arguments='id=16 debug', $service='system-auth', $control='sufficient', $before='pam_unix.so') {
  if $::kernel =='Linux' {
    if $::osfamily == 'RedHat' and $::operatingsystem !~ /Fedora|Amazon/ {
      #Insert Red Hat / Centos PAM Logic
      require ::pam
      pam { 'Insert Yubikey entry on system-auth':
        ensure => present,
        service => $::yubikey::config::service,
        type => 'auth',
        control => $::yubikey::config::control,
        module => 'pam_yubico.so',
        arguments => $::yubikey::config::arguments,
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
