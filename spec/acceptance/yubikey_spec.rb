require 'spec_helper_acceptance'

describe 'yubikey_class' do
    it 'should work idempotently with no errors' do
      pp = <<-EOM
      class { 'yubikey': }
      EOM
      apply_manifest(pp, :catch_failures => true)
      expect(apply_manifest(pp, :catch_failures => true).exit_code).to be_zero
      apply_manifest(pp, :catch_changes => true)
    end

    describe package('pam_yubico') do
      it { should be_installed }
    end
end
