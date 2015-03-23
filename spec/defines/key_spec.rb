require 'spec_helper'
describe 'yubikey::key', :type => :define do
        describe 'when configuring keys for root user ' do
                let (:facts) {{
                        :osfamily => 'RedHat',
                        :kernel => 'Linux',
                        :operatingsystem => 'Fedora',
                }}
		let (:title) {'root'} 
		let (:params) {  {
			:home => '/root',
			:group => 'root',
			:token => ['abcdefghijkl','mnopqrstuvwx'],
		} }
                it {
                        should contain_file('/root/.yubico/authorized_yubikeys').with({
                                'content' => 'root:abcdefghijkl:mnopqrstuvwx',
				'owner' => 'root',
				'group' => 'root',
                        })
                }
        end
end
