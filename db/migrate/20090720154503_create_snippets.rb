migration 1, :snippet do
  up do
    create_table :snippets do
      column :body, String, :nullable? => false
      column :name, String, :nullable? => false
      column :keyword, String, :nullable? => false
      column :created_at, DateTime, :nullable? => false
      column :updated_at, DateTime, :nullable? => false
    end
  end

  down do
    drop_table :snippets
  end
end
