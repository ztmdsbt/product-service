require 'spec_helper'

describe ProductStore::API do
  include Rack::Test::Methods

  def app
    ProductStore::API
  end

  describe ProductStore::API do
    let(:json_response) { JSON.parse(last_response.body, symbolize_names: true) }

    describe 'GET /' do
      before do
        get('/')
      end

      it 'returns application/hal+json' do
        expect(last_response.status).to eq(200)
        expect(last_response.content_type).to eq 'application/hal+json'
      end

      it 'returns index' do
        expect(json_response[:_links]).to eq({})
      end
    end

    describe 'GET /products' do
      subject { get '/products' }

      context 'when there are no products' do
        before do
          expect(ProductRepository).to receive(:all).and_return([])
        end

        it 'should return 200' do
          subject
          expect(last_response.status).to eq(200)
        end

        it 'returns an empty array of products' do
          subject
          expect(json_response).to eq(products: [])
        end
      end

      context 'when there are products' do
        let(:product1) { ModelFactory.build_product }
        let(:product2) { ModelFactory.build_product }

        before do
          allow(ProductRepository).to receive(:all).and_return([product1, product2])
        end

        it 'should return 200' do
          subject
          expect(last_response.status).to eq(200)
        end

        it 'returns an item in the array for each product' do
          subject
          expect(json_response[:products].length).to eq 2
        end
      end
    end

    describe 'GET /products/:id' do
      subject { get '/products/1' }

      context 'when the product does not exist' do
        before do
          expect(ProductRepository).to receive(:find).with('1').and_raise(RecordNotFoundError)
        end

        it 'should return a 404' do
          subject
          expect(last_response.not_found?).to be_truthy
        end
      end

      context 'when the product does exist' do
        before do
          expect(ProductRepository).to receive(:find).with('1').and_return(ModelFactory.build_product)
        end

        it 'should return the details of the product identified by the id provided' do
          subject
          expect(last_response.status).to eq 200
          expect(json_response[:id]).to eql 1
        end
      end
    end

    describe 'POST /products' do
      context 'with valid params' do
        subject { post '/products', product: ParamFactory.build_product }

        before do
          allow(ProductRepository).to receive(:save).and_return(1)
          allow(ProductRepository).to receive(:find).with(1).and_return(Product.new(id: 1))
          subject
        end

        it 'should create a new product' do
          expect(last_response.created?).to be_truthy
          expect(json_response[:id]).to eql 1
        end
      end

      context 'with existing product' do
        subject { post '/products', product: ParamFactory.build_product }

        before do
          allow(ProductRepository).to receive(:save).and_raise(RecordInvalidError)
          subject
        end

        it { expect(last_response.unprocessable?).to be_truthy }
      end

      context 'validation' do
        subject { post '/products', product: params }

        before { subject }

        context 'with nil product attribute' do
          let(:params) { ParamFactory.build_product(name: nil) }

          it { expect(last_response.bad_request?).to be_truthy }
        end
      end
    end

    describe 'PUT /products/:id' do
      # let(:content_type) { :CONTENT_TYPE, 'application/json' }
      subject { put '/products/1', product: ParamFactory.build_product(id: 1) }

      context 'with valid params' do
        before do
          allow(ProductRepository).to receive(:update).and_return(1)
          allow(ProductRepository).to receive(:find).with(1).and_return(Product.new(id: 1))
          subject
        end

        it 'should update the product' do
          expect(last_response.ok?).to be_truthy
          expect(json_response[:id]).to eql 1
        end
      end

      context 'with not existing product' do
        before do
          allow(ProductRepository).to receive(:update).and_raise(RecordNotFoundError)
          subject
        end

        it { expect(last_response.not_found?).to be_truthy }
      end

      context 'product name and category same as another exists product' do
        before do
          allow(ProductRepository).to receive(:update).and_raise(RecordInvalidError)
          subject
        end

        it { expect(last_response.unprocessable?).to be_truthy }
      end

      context 'with nil necessary attributes' do
        subject { put '/products/1', product: ParamFactory.build_product(name: nil) }

        before { subject }

        it { expect(last_response.bad_request?).to be_truthy }
      end
    end
  end
end
