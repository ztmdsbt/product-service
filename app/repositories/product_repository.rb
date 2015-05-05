class ProductRepository
  def self.all
    Database.db.relation(:products).as(:products).to_a
  end

  def self.find(id)
    product = find_product id
    raise RecordNotFoundError, 'Product not found' unless product
    product
  end

  def self.save(attrs)
    command.create.call(attrs.except(:id))[:id]
  end

  def self.update(attrs, id)
    # byebug
    raise RecordNotFoundError unless find_product id
    command.update.find(id).set(attrs)[:id]
  end

  def self.command
    Database.db.commands.products
  end

  def self.find_product(id)
    Database.db.relation(:products).as(:products).find(id).first
  end
end
