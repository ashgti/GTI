class Taxonomy
  include DataMapper::Resource
  
  property :id,   Serial,         :serial => true
  property :type, Discriminator
  ## TODO: Figure out taxonomies 
  # property :name, String,         :required => true, :unique => true, :index => true
end
