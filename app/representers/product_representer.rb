module ProductRepresenter
  include Roar::JSON::HAL
  include Roar::Hypermedia
  include Grape::Roar::Representer

  property :id
  property :category
  property :name
  property :created_at, as: :createAt
  property :updated_at, as: :updateAt
  property :expired_at, as: :expiredAt

  link :self do |opts|
    request = Grape::Request.new(opts[:env])
    "#{request.base_url}/products/#{id}"
  end

  # link :origin do |_opts|
  #   origin_url
  # end
end
