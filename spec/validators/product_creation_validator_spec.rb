require 'spec_helper'

describe ProductCreationValidator do
  subject { ProductCreationValidator.call params }

  context 'should raise RecordInvalidError when name and category same as existing product.' do
    let(:params) { ModelFactory.create_product.attributes }

    it { expect { subject }.to raise_error(RecordInvalidError, 'Product already exists.') }
  end

  context 'should not raise any error when product is unique.' do
    let(:params) { ModelFactory.build_product.attributes }

    it { expect { subject }.to_not raise_error }
  end
end
