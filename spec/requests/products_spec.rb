require 'spec_helper'

describe ProductStore::API do
  include Rack::Test::Methods

  def app
    ProductStore::API
  end

  describe ProductStore::API do
    let(:json_response) { JSON.parse(last_response.body, symbolize_names: true) }

    describe 'GET /products' do
      subject { get '/products' }

      before do
        2.times { ModelFactory.create_product }
        subject
      end

      it { expect(last_response).to be_ok }

      it { expect(json_response[:products].length).to eq 2 }
    end

    describe 'GET /products/:id' do
      subject { get "/products/#{id}" }

      context 'when the product does not exist' do
        let(:id) { 12_345 }

        before { subject }

        it { expect(last_response).to be_not_found }
      end

      context 'when the product exists' do
        let(:product) { ModelFactory.create_product }
        let(:id) { product.id }

        before { subject }

        it { expect(last_response.ok?).to be_truthy }

        it 'should return the details of the product identified by the id provided' do
          expect(json_response).to be_json_of_product product
        end
      end
    end

    describe 'POST /products' do
      subject { post '/products', product: params }

      before { subject }

      context 'should create a new product' do
        let(:params) { ParamFactory.build_product }

        it { expect(last_response).to be_created }
        it do
          product = ProductRepository.find(json_response[:id])
          expect(json_response).to be_json_of_product product
        end
      end

      context 'with invalid params' do
        let(:params) { ParamFactory.build_product(name: nil) }

        it { expect(last_response).to be_bad_request }
      end

      context 'with existing product' do
        let(:exist_product) { ModelFactory.create_product(categyory: 'abc', name: 'xyz') }
        let(:params) { ParamFactory.build_product(name: exist_product.name, category: exist_product.category) }
        it { expect(last_response).to be_unprocessable }
      end
    end
  end
end
