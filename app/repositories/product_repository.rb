class ProductRepository
  def self.all
    Database.db.relation(:products).as(:products).to_a
  end

  def self.find(_id)
    product = Database.db.relation(:products).as(:products).first
    raise RecordNotFoundError, 'Product not found' unless product
    product
  end

  def self.save(attrs)
    command.create.call(attrs.except(:id))[:id]
  end

  def self.command
    Database.db.command(:products)
  end
end
