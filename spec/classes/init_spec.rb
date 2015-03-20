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
			#should contain_file('/etc/pam.d/system-auth').with_content(/pam_yubico/)
		}
	end
end
