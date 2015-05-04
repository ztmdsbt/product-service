require 'rspec/expectations'

module CustomMatchers
  RSpec::Matchers.define :be_json_of_product do |expected|
    match do |actual|
      expect(actual[:id]).to eq expected.id
      expect(actual[:category]).to eq expected.category
      expect(actual[:name]).to eq expected.name
      expect(actual[:createdAt]).to eq expected.created_at.to_s
      expect(actual[:updatedAt]).to eq expected.updated_at.to_s
      expect(actual[:expiredAt]).to eq expected.expired_at.to_s

      links = actual[:_links]
      expect(links[:self]).to eq(href: "http://example.org/products/#{expected.id}")
      # expect(links[:origin]).to eq(href: expected.origin_url)
    end
  end
end
