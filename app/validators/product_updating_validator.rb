class ProductUpdatingValidator
  def self.call(params)
    raise RecordNotFoundError, 'Product not exists.' if product_not_exists?(params)
    raise RecordInvalidError, 'Product name and category same as another product.' if product_same_as_another?(params)
  end

  def self.product_not_exists?(params)
    !relation.find(params[:id]).to_a.any?
  end

  def self.product_same_as_another?(params)
    product = relation.find_by_category_and_name(params[:category], params[:name]).to_a
    !product_not_exists?(params) && product.any? && product.first[:id] != params[:id]
  end

  def self.relation
    Database.db.relation(:products)
  end
end
