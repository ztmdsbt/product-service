require 'spec_helper'

describe ProductUpdatingValidator do
  subject { ProductUpdatingValidator.call params }

  context 'should raise RecordInvalidError when product name and category same as existing product.' do
    let(:product) { ModelFactory.create_product }
    let(:existing_product) { ModelFactory.create_product(id: 2) }
    let(:params) { ModelFactory.build_product(id: product.id, name: existing_product.name, category: existing_product.category) }

    it { expect { subject }.to raise_error(RecordInvalidError, 'Product name and category same as another product.') }
  end

  context 'should raise RecordNotFoundError when product cannot be found.' do
    let(:params) { ModelFactory.build_product }

    it { expect { subject }.to raise_error(RecordNotFoundError, 'Product not exists.') }
  end

  context 'should not raise any error when product name and category is unique.' do
    let(:product) { ModelFactory.create_product }
    let(:params) { ModelFactory.build_product(id: product.id, name: 'abc', category: 'xyz') }

    it { expect { subject }.to_not raise_error }
  end
end
