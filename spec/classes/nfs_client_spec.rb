require 'spec_helper'
describe 'nfs::client' do
  context 'when on Debian' do
    let (:facts) { {
      :operatingsystem => 'Debian',
      :osfamily        => 'Debian',
      :lsbdistcodename => 'wheezy',
    } }

    it { should compile.with_all_deps }
  end
end
