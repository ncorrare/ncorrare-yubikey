##Default parameters for the module
class yubikey::params {
  if $::osfamily == 'RedHat' {
    $service = ['system-auth','password-auth']
  } 
  elsif $::osfamily == 'Debian' {
    $service = ['common-auth']
  }

  $arguments = ['debug','id=16']
  $control   = 'sufficient'
  $beforemod = 'pam_unix.so'
}
