# Define a type to iterate through the $service array
define yubikey::addauthyubico (
  $control = $yubikey::config::control,
  $arguments = $yubikey::config::arguments,
  $beforemod = $ubikey::config::beforemod,
) {
  pam { "Insert Yubikey entry on ${name} as ${yubikey::config::control}":
    ensure    => present,
    service   => $name,
    type      => 'auth',
    control   => $control,
    module    => 'pam_yubico.so',
    arguments => $arguments,
    position  => "before *[type=\"auth\" and module=\"${beforemod}\"]",
  }
}
