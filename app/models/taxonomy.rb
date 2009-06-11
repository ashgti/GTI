class Taxonomy
  include DataMapper::Resource
  
  property :id,   Serial,         :serial => true
  property :name, String,         :required => true, :unique => true, :index => true
  property :type, Discriminator
end
