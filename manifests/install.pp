#The following class will install the Yubikey PAM module from the 
#right repository in each $operatingsystem.
#Debian and Windows are unsupported so far.
class yubikey::install {
  if $::kernel =='Linux' {
    if $::osfamily == 'RedHat' and $::operatingsystem !~ /Fedora|Amazon/ {
      require ::epel
      package { 'pam_yubico' :
        ensure => installed,
      }
    } elsif $::osfamily == 'RedHat' and $::operatingsystem =~ /Fedora/ {
      package { 'pam_yubico' :
        ensure => installed,
      }
    } elsif $::osfamily == 'Debian' and $::operatingsystem =~ /Ubuntu/ {
      require ::apt
      apt::ppa { 'ppa:yubico/stable' :
      notify => Exec['apt_update']
      }->
      package { 'libpam-yubico' :
        ensure => installed
      }
    } else {
      notice ("${::operatingsystem} is not supported")
    }
  } else {
    notice ("${::operatingsystem} is not supported")
  }
}
