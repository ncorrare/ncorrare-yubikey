##Default parameters for the module
class yubikey::params {
  if $::osfamily == 'RedHat' {
    $service='system-auth'
  } elseif $::osfamily == 'Debian' {
    $service='common-auth'
  }

  $arguments="debug"
  $control="sufficient"
  $beforemod="pam_unix.so"
}
