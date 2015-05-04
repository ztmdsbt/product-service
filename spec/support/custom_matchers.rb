require 'rspec/expectations'

module CustomMatchers
  RSpec::Matchers.define :be_json_of_product do |expected|
    match do |actual|
      expect(actual[:id]).to eq expected.id
      expect(actual[:category]).to eq expected.category
      expect(actual[:name]).to eq expected.name
      expect(actual[:created_at]).to eq expected.created_at
      expect(actual[:updated_at]).to eq expected.updated_at
      expect(actual[:expired_at]).to eq expected.expired_at

      links = actual[:_links]
      expect(links[:self]).to eq(href: "http://example.org/products/#{expected.id}")
      # expect(links[:origin]).to eq(href: expected.origin_url)
    end
  end
end
