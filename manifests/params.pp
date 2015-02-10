##Default parameters for the module
class yubikey::params {
  if $::osfamily == 'RedHat' {
    $service = ['system-auth','password-auth']
    $pkgname = 'pam_yubico'
  }
  elsif $::osfamily == 'Debian' {
    $service = ['common-auth']
    $pkgname = 'libpam-yubico'
  }
  $arguments    = ['debug','id=16']
  $control      = 'sufficient'
  $beforemod    = 'pam_unix.so'
  $validcontrol = ['requisite','required','sufficient','optional']
  $managedeps   = true
}
