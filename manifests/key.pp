#Defining the type yubikey:key to allow users to authenticate with Yubikeys.
define yubikey::key ($token,$home,$group) {
  require ::yubikey::config
  validate_string($home)
  validate_string($group)
  validate_array($token)
  $tokens=join($token,':')
  file { "${home}/.yubico/" :
    ensure => directory,
    owner  => $name,
    group  => $group,
  }
  file { "${home}/.yubico/authorized_yubikeys" :
    ensure  => 'present',
    owner   => $name,
    group   => $group,
    content => "${name}:${tokens}",
    require => File["${home}/.yubico/"]
  }
}

