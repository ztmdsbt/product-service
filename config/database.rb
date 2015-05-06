require 'rom-sql'
class Database
  def self.db
    @db ||= setup_all
  end

  def self.setup_all
    db = setup_connection
    setup_relations(db)
    setup_mappings(db)
    setup_commands(db)
    db.finalize
  end

  def self.setup_connection
    ROM.setup(
      :sql,
      "postgres://#{ENV.fetch('PRODUCTS_DB_URL')}/#{db_name}",
      user:     ENV.fetch('PRODUCTS_DB_USERNAME'),
      password: ENV.fetch('PRODUCTS_DB_PASSWORD')
    )
  end

  def self.setup_relations(rom)
    rom.relation(:products) do
      def find(id)
        where(id: id)
      end

      def find_by_category_and_name(category, name)
        where(category: category, name: name)
      end
    end
  end

  def self.setup_mappings(rom)
    rom.mappers do
      define(:products) { model Product }
    end
  end

  def self.setup_commands(rom)
    rom.commands(:products) do
      define(:create) do
        result :one
        validator ProductCreationValidator
      end

      define(:update) do
        result :one
        validator ProductUpdatingValidator
      end
    end
  end

  def self.db_name
    ENV['RACK_ENV'] == 'production' ? 'products' : "products_#{ENV['RACK_ENV']}"
  end
end
