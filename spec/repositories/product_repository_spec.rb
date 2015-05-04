require 'spec_helper'

describe ProductRepository do
  describe '#find' do
    subject(:product) { ProductRepository.find(id) }

    context 'when the product exists' do
      context 'without billing entity' do
        let(:expected) { ModelFactory.create_product }
        let(:id) { expected.id }

        it { expect(product.id).to eql expected.id }
      end
    end

    context 'when the product does not exists' do
      let(:id) { 12_012 }

      it { expect { subject }.to raise_error(RecordNotFoundError) }
    end
  end

  describe '#all' do
    subject(:products) { ProductRepository.all }

    before do
      2.times { ModelFactory.create_product }
    end

    it { expect(products.count).to eql 2 }

    it { expect(products.first).to be_a Product }

    it { expect(products.last).to be_a Product }
  end

  describe '#save' do
    subject(:id) { ProductRepository.save product_attrs }

    context 'with existing product' do
      let(:product_attrs) { ModelFactory.create_product.attributes }

      it 'should raise error and not save billing entity' do
        expect { subject }.to raise_error RecordInvalidError
      end
    end

    context 'should save a new product, when product not exists' do
      let(:product_attrs) { ModelFactory.build_product.attributes }

      it { expect(ProductRepository.find id).to be_a Product }
    end
  end
end
