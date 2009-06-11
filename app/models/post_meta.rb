class PostMeta
  include DataMapper::Resource
  
  property :id, Serial

  class << self
    def storage_name repo
      'post_meta'
    end
  end
end
