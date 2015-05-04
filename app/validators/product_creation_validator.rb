class ProductCreationValidator
  def self.call(params)
    raise RecordInvalidError, 'Product already exists.' if product_exists?(params)
  end

  def self.product_exists?(params)
    relation.find_by_category_and_name(params[:category], params[:name]).to_a.any?
  end

  def self.relation
    Database.db.relation(:products)
  end
end
