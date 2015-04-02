
require 'spec_helper'

describe 'nfs::client' do
  on_supported_os.each do |os, facts|
    context "when on #{os}" do
      let (:facts) do
        facts.merge({
          :concat_basedir => '/tmp'
        })
      end

      it { should compile.with_all_deps }
    end
  end
end
