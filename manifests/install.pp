#The following class will install the Yubikey PAM module from the 
#right repository in each $operatingsystem.
#Debian and Windows are unsupported so far.
class yubikey::install (
  $pkgname,
  $managedeps,
) {
  validate_string($pkgname)
  validate_bool($managedeps)
  if $::kernel =='Linux' {
    if $::osfamily == 'RedHat' and $::operatingsystem !~ /Fedora|Amazon/ {
      if $managedeps {
        require ::epel
      }
      package { $pkgname :
        ensure => installed,
      }
    } elsif $::osfamily == 'RedHat' and $::operatingsystem =~ /Fedora/ {
      package { $pkgname :
        ensure => installed,
      }
    } elsif $::osfamily == 'Debian' and $::operatingsystem =~ /Ubuntu/ {
      if $managedeps {
        include ::apt
      }
      apt::ppa { 'ppa:yubico/stable' :}
      package { $pkgname :
        ensure => installed
      }
    } else {
      fail ("${::operatingsystem} is not supported")
    }
  } else {
    fail ("${::operatingsystem} is not supported")
  }
}
