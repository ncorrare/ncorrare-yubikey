#Defining the type yubikey:key to allow users to authenticate with Yubikeys.
define yubikey::key ($token,$home,$group) {
  require ::yubikey::config
  validate_string($home)
  validate_string($group)
  validate_re($token,'^[a-z]{12}$')
  file { "${home}/.yubico/" :
    ensure => directory,
    owner  => $name,
    group  => $group,
  }
  file { "${home}/.yubico/authorized_yubikeys" :
    ensure  => 'present',
    owner   => $name,
    group   => $group,
    content => "${name}:${token}",
    require => File["${home}/.yubico/"]
  }
}

