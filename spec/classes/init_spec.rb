require 'spec_helper'
describe 'yubikey' do

  context 'with defaults for all parameters' do
    it { should contain_class('yubikey') }
  end
end
