class Layout
  include DataMapper::Resource

  ## Properties
  property :id,       Serial         
  property :name,     String,           :length => (5..50), :lazy => true
  property :body,     Text,             :lazy => false
  property :deleted,  ParanoidBoolean

  ## Validations
  validates_present :name
  
  ## Extras
  timestamps :at
  # is_versioned :on => :updated_at  # not working with STI
  
  ## Associations
  # has n, :contents
  
  def process
    register_callables
  end
  
  class << self
  end
end