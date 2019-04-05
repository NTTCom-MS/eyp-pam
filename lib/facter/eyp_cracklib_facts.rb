# /etc/security/pwquality.conf

# minlen - Minimum acceptable size for the new password
minlen = Facter::Util::Resolution.exec('grep ^minlen /etc/security/pwquality.conf | awk \'{ print $NF }\'').to_s

# ocredit - The maximum credit for having other characters in the new password
ocredit = Facter::Util::Resolution.exec('grep ^ocredit /etc/security/pwquality.conf | awk \'{ print $NF }\'').to_s

# lcredit - The maximum credit for having lowercase characters in the new password
lcredit = Facter::Util::Resolution.exec('grep ^lcredit /etc/security/pwquality.conf | awk \'{ print $NF }\'').to_s

# ucredit - The maximum credit for having uppercase characters in the new password
ucredit = Facter::Util::Resolution.exec('grep ^ucredit /etc/security/pwquality.conf | awk \'{ print $NF }\'').to_s

# dcredit - The maximum credit for having digits in the new password
dcredit = Facter::Util::Resolution.exec('grep ^dcredit /etc/security/pwquality.conf | awk \'{ print $NF }\'').to_s

unless minlen.nil? or minlen.empty?
  Facter.add('eyp_pam_cracklib_password_minlen') do
      setcode do
        minlen
      end
  end
  Facter.add('eyp_pam_cracklib_password_minlen_description') do
      setcode do
        'Minimum acceptable size for the new password'
      end
  end
end

unless ocredit.nil? or ocredit.empty?
  Facter.add('eyp_pam_cracklib_password_ocredit') do
      setcode do
        ocredit
      end
  end
  Facter.add('eyp_pam_cracklib_password_ocredit_description') do
      setcode do
        'The maximum credit for having other characters in the new password'
      end
  end
end

unless lcredit.nil? or lcredit.empty?
  Facter.add('eyp_pam_cracklib_password_lcredit') do
      setcode do
        lcredit
      end
  end
  Facter.add('eyp_pam_cracklib_password_lcredit_description') do
      setcode do
        'The maximum credit for having lowercase characters in the new password'
      end
  end
end

unless ucredit.nil? or ucredit.empty?
  Facter.add('eyp_pam_cracklib_password_ucredit') do
      setcode do
        ucredit
      end
  end
  Facter.add('eyp_pam_cracklib_password_ucredit_description') do
      setcode do
        'The maximum credit for having uppercase characters in the new password'
      end
  end
end

unless dcredit.nil? or dcredit.empty?
  Facter.add('eyp_pam_cracklib_password_dcredit') do
      setcode do
        dcredit
      end
  end
  Facter.add('eyp_pam_cracklib_password_dcredit_description') do
      setcode do
        'The maximum credit for having digits in the new password'
      end
  end
end
