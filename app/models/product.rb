class Product
  include Virtus.model

  attribute :id, Integer
  attribute :category, String
  attribute :name, String
  attribute :created_at, DateTime
  attribute :updated_at, DateTime
  attribute :expired_at, DateTime
end
