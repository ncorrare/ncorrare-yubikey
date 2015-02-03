#Defining the type yubikey:key to allow users to authenticate with Yubikeys.
define yubikey::key ($token) {
  require ::yubikey::config
  file { "/home/${name}/.yubico/authorized_yubikeys" :
    ensure  => 'present',
    content => "${name}:${token}",
  }
}

