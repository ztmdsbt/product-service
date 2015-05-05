require 'spec_helper'

describe ProductRepresenter do
  before { allow(Grape::Request).to receive(:new) { double(:request, base_url: 'http://localhost') } }

  describe 'json format' do
    let(:product) { ModelFactory.build_product }
    subject { JSON.parse(product.extend(ProductRepresenter).to_json, symbolize_names: true) }

    it 'renders the id' do
      expect(subject[:id]).to eq product.id
    end

    it 'renders the category' do
      expect(subject[:category]).to eq product.category
    end

    it 'renders the name' do
      expect(subject[:name]).to eq product.name
    end

    it 'renders the createdAt' do
      expect(subject[:createdAt]).to eq product.created_at.to_s
    end

    it 'renders the updatedAt' do
      expect(subject[:updatedAt]).to eq product.updated_at.to_s
    end

    it 'renders the expiredAt' do
      expect(subject[:expiredAt]).to eq product.expired_at.to_s
    end

    it 'renders the link to self' do
      expect(subject[:_links][:self]).to eq(href: "http://localhost/products/#{product.id}")
    end
  end
end
