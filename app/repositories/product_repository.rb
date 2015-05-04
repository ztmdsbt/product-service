class ProductRepository
  def self.all
    Database.db.relation(:products).as(:products).to_a
  end

  def self.find(id)
    product = Database.db.relation(:products).first
    raise RecordNotFoundError, 'Product not found' unless product
  end

  def self.save(attrs)
    Database.db.command(:products).create.call attrs
  end
end
