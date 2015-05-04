class ParamFactory
  def self.build_product(overrides = {})
    {
      category:   FFaker::Lorem.word,
      name:       FFaker::Address.street_name,
      created_at: FFaker::Time.date,
      updated_at: FFaker::Time.date,
      expired_at: FFaker::Time.date
    }.merge(overrides)
  end
end
