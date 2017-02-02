require 'spec_helper_acceptance'
require_relative './version.rb'

describe 'apache class' do

  context 'basic setup' do
    # Using puppet_apply as a helper
    it 'should work with no errors' do
      pp = <<-EOF

      class { 'pam::ttyaudit':
        disable => undef,
        enable => [ '*' ],
      }

      EOF

      # Run it twice and test for idempotency
      expect(apply_manifest(pp).exit_code).to_not eq(1)
      expect(apply_manifest(pp).exit_code).to eq(0)
    end

    describe file('/etc/pam.d/sshd') do
      it { should be_file }
      its(:content) { should match 'session required pam_tty_audit.so enable=*' }
    end

  end

end
