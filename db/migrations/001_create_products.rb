Sequel.migration do
  change do
    create_table :products do
      primary_key :id
      String :category
      String :name
      DateTime :created_at
      DateTime :updated_at
      DateTime :expired_at
    end
  end
end
