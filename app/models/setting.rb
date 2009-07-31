class Setting
  include DataMapper::Resource
  
  property :key,       String, :length => (1..40), :key => true
  property :value,     Text
  property :auto_load, Boolean
  
  class << self
  end
end