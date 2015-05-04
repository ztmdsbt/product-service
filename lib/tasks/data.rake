namespace :data do
  require_relative '../boot'

  desc 'create a product'
  task :create_product do
    product = Product.new(category:   FFaker::Lorem.word,
                          name:       FFaker::Address.street_name,
                          created_at: FFaker::Time.date,
                          updated_at: FFaker::Time.date,
                          expired_at: FFaker::Time.date)
    byebug
    puts "Created product with id: #{ProductRepository.save product.attributes}"
  end
end
