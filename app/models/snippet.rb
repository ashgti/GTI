class Snippet
  include DataMapper::Resource

  property :id,       Serial
  property :name,     String, :nullable => false
  property :keyword,  String, :nullable => false
  property :body,     Text
  
  ## Validations
  validates_present :keyword, :name
  
  ## Extras
  timestamps :at
end
