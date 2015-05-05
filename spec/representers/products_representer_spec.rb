require 'spec_helper'

describe ProductsRepresenter do
  before { allow(Grape::Request).to receive(:new) { double(:request, base_url: 'http://localhost') } }

  describe 'json format' do
    let(:product1) { ModelFactory.build_product }
    let(:product2) { ModelFactory.build_product }
    let(:products) { [product1, product2] }

    subject { JSON.parse(products.extend(ProductsRepresenter).to_json, symbolize_names: true) }

    it 'renders all products' do
      expect(subject[:products].length).to be 2
    end
  end
end
