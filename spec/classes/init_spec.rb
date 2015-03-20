require 'spec_helper'
describe 'yubikey', :type => :class do
	describe 'when called with no parameters on RedHat' do
		let (:facts) {{
			:osfamily => 'RedHat',
			:kernel => 'Linux',
			:operatingsystem => 'Fedora',
		}}
		it {
			should contain_package('pam_yubico').with({
			  'ensure'=>'installed',
			  'name'  =>'pam_yubico',
			})
			should contain_file('/var/run/pam-debug.log').with({
				'ensure'=>'present',
			})
			#should contain_class('epel') 
		}
	end
	describe 'when called with no parameters on Ubuntu' do
		let (:facts) {{
			:osfamily => 'Debian',
			:kernel => 'Linux',
			:operatingsystem => 'Ubuntu',
			:lsbdistid => 'Ubuntu',
			:lsbdistcodename => 'precise',
		}}
		it {
			should contain_package('libpam-yubico').with({
			  'ensure'=>'installed',
			  'name'  =>'libpam-yubico',
			})
			should contain_file('/var/run/pam-debug.log').with({
				'ensure'=>'present',
			})
			should contain_class('apt') 
		}
	end
end
