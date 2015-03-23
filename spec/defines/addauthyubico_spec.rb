require 'spec_helper'
describe 'yubikey::addauthyubico', :type => :define do
        describe 'when using defaults on RedHat' do
                let (:facts) {{
                        :osfamily => 'RedHat',
                        :kernel => 'Linux',
                        :operatingsystem => 'Fedora',
                }}
		let (:title) {'system-auth'} 
		let (:params) {  {
			:arguments => ['debug','id=16'],
			:control => 'sufficient',
			:beforemod => 'pam_unix.so',
		} }
                it {
                        should compile 
                }
        end
end
