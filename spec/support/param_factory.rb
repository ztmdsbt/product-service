class ParamFactory
  def self.build_product(overrides = {})
    {
      category:  FFaker::Lorem.word,
      name:      FFaker::Address.street_name,
      createdAt: FFaker::Time.date,
      updatedAt: FFaker::Time.date,
      expiredAt: FFaker::Time.date
    }.merge(overrides)
  end
end
