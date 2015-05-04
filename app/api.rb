module ProductStore
  class API < Grape::API
    content_type :json, 'application/hal+json'
    format :json
    formatter :json, Grape::Formatter::Roar

    helpers SharedParams

    rescue_from RecordNotFoundError do |error|
      Rack::Response.new({ errors: error.message }.to_json, 404).finish
    end

    rescue_from RecordInvalidError do |error|
      Rack::Response.new({ errors: error.message }.to_json, 422).finish
    end

    before do
      LOGGER.info "#{env['REMOTE_ADDR']} #{env['HTTP_USER_AGENT']} #{env['REQUEST_METHOD']} #{env['REQUEST_PATH']}"
    end

    resource :products do
      get do
        present ProductRepository.all, with: ProductsRepresenter
      end

      route_param :id do
        get do
          present ProductRepository.find(params[:id]), with: ProductRepresenter
        end
      end

      params do
        use :product
      end
      post do
        present ProductRepository.find(ProductRepository.save(convert_param_keys(params[:product]))),
                with: ProductRepresenter
      end
    end

    get '/' do
      { '_links' => HAL::Index.links }
    end
  end
end
