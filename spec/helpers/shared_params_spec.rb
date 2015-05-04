require 'spec_helper'

describe SharedParams do
  class SharedParamsTest
    include SharedParams
  end

  let(:shared_params_test) { SharedParamsTest.new }

  describe '#convert_param_keys' do
    let(:params) do
      [
        { 'updatedAt' => 'updated_at' },
        { 'createdAt' => 'created_at' }
      ]
    end

    subject { shared_params_test.convert_param_keys(params) }

    it 'should covert the keys to underscore' do
      expect(subject).to eq [
        { updated_at: 'updated_at' },
        { created_at: 'created_at' }
      ]
    end
  end
end
