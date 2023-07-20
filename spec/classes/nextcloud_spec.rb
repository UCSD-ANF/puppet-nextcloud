require 'spec_helper'

describe 'nextcloud' do
  shared_examples_for 'Supported Platform' do
    it { is_expected.to compile }
  end

  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }

      it_behaves_like 'Supported Platform'
    end
  end
end
