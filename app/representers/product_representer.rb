module ProductRepresenter
  include Roar::JSON::HAL
  include Roar::Hypermedia
  include Grape::Roar::Representer

  property :id
  property :category
  property :name
  property :created_at
  property :updated_at
  property :expired_at

  link :self do |opts|
    request = Grape::Request.new(opts[:env])
    "#{request.base_url}/products/#{id}"
  end

  link :origin do |opts|
    origin_url
  end
end
