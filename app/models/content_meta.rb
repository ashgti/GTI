class ContentMeta
  include DataMapper::Resource
  
  property :content_id, Integer,  :key => true
  property :meta_key,   String,   :key => true, :length => (1..40)
  property :meta_value, Text
  
  belongs_to :content
  
  class << self
    def storage_name repo
      'content_meta'
    end
  end
end
