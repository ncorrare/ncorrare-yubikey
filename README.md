# yubikey

#### Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Setup - The basics of getting started with yubikey](#setup)
    * [What yubikey affects](#what-yubikey-affects)
    * [Beginning with yubikey](#beginning-with-yubikey)
4. [Usage - Configuration options and additional functionality](#usage)
5. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)

## Overview

This module installs, configures and assigns Yubikeys in a system.

## Module Description

The module installs the yubico PAM libraries that enable using yubikeys as a
supported authentication method. Using the default variables it will enable system
wide yubikey authentication for all users defined using the yubikey::key type.
It assumes a default PAM configuration, but for complex environments the setup
can be adjusted.

## Setup

### What yubikey affects

* The PAM yubico libraries will be installed from either the distribution
  repo or Yubico's depending on the Linux Distribution.
* As default, it will be configured as sufficient authentication before
  the PAM Unix module. Please review your PAM configuration.
* As with any PAM change, it is strongly suggested to test it with a shell
  open, since it may lock you out of the system.

### Beginning with yubikey

To configure a system, begin with adding the class.
```puppet 
class { 'yubikey' :}
```

## Usage

The module will install the require bits, and update the PAM configuration to
have yubikey as a "sufficient" authentication method, before pam_unix.so (i.e.
before user/password). By default, it will also enable debugging. Consider editing
the arguments for production systems:

```puppet
class { '::yubikey::config' :
  arguments => 'id=16'
  }
  ```
For other arguments, or using with the Yubico Radius, please check the documentation
on which parameters to use on https://developers.yubico.com/yubico-pam/ .

To configure a user, define a new key:
```puppet
yubikey::key { 'username' :
  token => 'token'
  }
 ``` 
Where token is the Yubikey token ID. So far it only accepts a string and not an array.
This will create a new file in the user's home directory (~/.yubico/authorized_yubikeys)
with the authorization mapping.

## Reference

The ::yubikey::config class accepts the following variables:

* $arguments: Defaults to 'debug'. Please note that augeas fails when using a '=' sign.
  Currently troubleshooting why that happens.
* $service: Defaults to system-auth in RedHat systems and common-auth in Ubuntu systems.
  Depending on your implementation, you might want to have yubikey authentication on a
  particular service (like sshd) so check your distribution documentation on how PAM
  is configured for your system.
* $control: Defaults to 'sufficient'. Again, depending on your setup, you may want to add 
  other authentication controls. Refer to the PAM documentation. Module will accept requisite,
  required, sufficient or optional.
* $beforemod: Defaults to 'pam_unix.so'. Works with most default PAM setups.


## Limitations

So far this has only been tested in Ubuntu and Centos. Should work in RHEL, Fedora, and Debian.
Please test it and let me know.
Also do know that this code is not endorsed by Yubico in any way, so use it at your own risk.

## Development

Regular rules apply, clone, PR, and I'll have a look. Generally on irc (#puppet and others on Freenode),
my nick is sgtpepper so feel free to contact me if you have any doubts.
