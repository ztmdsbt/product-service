module SharedParams
  extend Grape::API::Helpers

  params :product do |_options|
    requires :product, type: Hash do
      requires :category, type: String, allow_blank: false
      requires :name, type: String, allow_blank: false
      requires :created_at, type: DateTime, allow_blank: false
      optional :updated_at, type: DateTime, allow_blank: false
      optional :expired_at, type: DateTime, allow_blank: false
    end
  end

  def convert_param_keys(value)
    case value
      when Array
        value.map { |v| convert_param_keys(v) }
      when Hash
        Hash[value.map { |k, v| [underscore(k), convert_param_keys(v)] }]
      else
        value
    end
  end

  private

  def underscore(string)
    string.gsub(/::/, '/')
      .gsub(/([A-Z]+)([A-Z][a-z])/, '\1_\2')
      .gsub(/([a-z\d])([A-Z])/, '\1_\2')
      .tr('-', '_')
      .downcase
      .to_sym
  end
end
