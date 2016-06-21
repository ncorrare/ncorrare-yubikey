require 'beaker-rspec'
require 'beaker/puppet_install_helper'


run_puppet_install_helper unless ENV['BEAKER_provision'] == 'no'
#run_puppet_install_helper unless ENV['BEAKER_provision'] == 'no'

#PUPPET_INSTALL_VERSION="1.5.0" PUPPET_INSTALL_TYPE="agent" BEAKER_set="centos-7-docker"
#PUPPET_INSTALL_VERSION="1.5.0" 
#PUPPET_INSTALL_TYPE="agent" 
#BEAKER_set="default"

UNSUPPORTED_PLATFORMS = ['Suse','windows','AIX','Solaris']

RSpec.configure do |c|
  proj_root = File.expand_path(File.join(File.dirname(__FILE__), '..'))

  c.formatter = :documentation

  # Configure all nodes in nodeset
  c.before :suite do
    puppet_module_install(:source => proj_root, :module_name => 'yubikey')
    hosts.each do |host|
      on host, puppet('config', 'set', 'modulepath', '/etc/puppetlabs/code/modules'), { :acceptable_exit_codes => [0,1] }
      on host, puppet('module', 'install', 'puppetlabs-stdlib'), { :acceptable_exit_codes => [0,1] }
      on host, puppet('module', 'install', 'stahnma-epel'), { :acceptable_exit_codes => [0,1] }
      #on host, puppet('module', 'install', '--verbose', 'herculesteam-augeasproviders'), { :acceptable_exit_codes => [0,1] }
      on host, puppet('module', 'install', '--ignore-dependencies', 'herculesteam-augeasproviders_core'), { :acceptable_exit_codes => [0,1] }
      on host, puppet('module', 'install', '--ignore-dependencies', 'herculesteam-augeasproviders_pam'), { :acceptable_exit_codes => [0,1] }
      on host, puppet('module', 'install', '--ignore-dependencies', 'puppetlabs-apt'), { :acceptable_exit_codes => [0,1] }
    end
  end
end
