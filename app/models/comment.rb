class Comment
  include DataMapper::Resource
  
  property :id, Serial, :serial => true
  property :by, String
  property :content, Text #, :lazy => [:show]
  property :user_ip, IPAddress 
  property :create_at, DateTime
  property :modified_at, DateTime
  property :status, Enum[:published, :draft]
  
  belongs_to :user
  # belongs_to :post
end
