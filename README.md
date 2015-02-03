# yubikey

#### Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Setup - The basics of getting started with yubikey](#setup)
    * [What yubikey affects](#what-yubikey-affects)
    * [Setup requirements](#setup-requirements)
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
* As with any PAM changed, it is strongly suggested to test it with a shell
  open

### Setup Requirements **OPTIONAL**

If your module requires anything extra before setting up (pluginsync enabled,
etc.), mention it here.

### Beginning with yubikey

The very basic steps needed for a user to get the module up and running.

If your most recent release breaks compatibility or requires particular steps
for upgrading, you may wish to include an additional section here: Upgrading
(For an example, see http://forge.puppetlabs.com/puppetlabs/firewall).

## Usage

Put the classes, types, and resources for customizing, configuring, and doing
the fancy stuff with your module here.

## Reference

Here, list the classes, types, providers, facts, etc contained in your module.
This section should include all of the under-the-hood workings of your module so
people know what the module is touching on their system but don't need to mess
with things. (We are working on automating this section!)

## Limitations

This is where you list OS compatibility, version compatibility, etc.

## Development

Since your module is awesome, other users will want to play with it. Let them
know what the ground rules for contributing are.

## Release Notes/Contributors/Etc **Optional**

If you aren't using changelog, put your release notes here (though you should
consider using changelog). You may also add any additional sections you feel are
necessary or important to include here. Please use the `## ` header.
