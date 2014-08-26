require 'spec_helper'
describe 'centreon' do

  context 'with defaults for all parameters' do
    it { should contain_class('centreon') }
  end
end
