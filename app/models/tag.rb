class Tag < Taxonomy
  validates_is_unique :name
  validates_present :name
  
  # belongs_to :pages
end
