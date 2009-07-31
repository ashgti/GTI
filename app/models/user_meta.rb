class UserMeta
  include DataMapper::Resource
  
  ## Properties
  property :user_id,    Integer, :key => true
  property :meta_key,   String,  :key => true
  property :meta_value, Text

  ## Associations 
  belongs_to :user
  
  class << self
    def storage_name repo
      'user_meta'
    end
  end
end
