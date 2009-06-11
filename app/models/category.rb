class Category < Taxonomy
  validates_is_unique :name
  validates_present :name
  
  has n, :posts, :through => Resource # has_and_belongs_to_many
end
