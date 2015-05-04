class ModelFactory
  def self.build_product(overrides = {})
    defaults = {
      id:         1,
      category:   FFaker::Lorem.word,
      name:       FFaker::Address.street_name,
      created_at: FFaker::Time.date,
      updated_at: FFaker::Time.date,
      expired_at: FFaker::Time.date
    }
    Product.new(defaults.merge(overrides))
  end

  def self.create_product(overrides = {})
    product       = build_product(overrides)
    product_attrs = product.attributes
    ProductRepository.find(ProductRepository.save(product_attrs))
  end
end
