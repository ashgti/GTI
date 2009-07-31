# raise Execpetion "this is where i came frome"

class Category < Taxonomy
  validates_is_unique :name
  validates_present   :name
  
  has n, :pages, :through => Resource # has_and_belongs_to_many
end
