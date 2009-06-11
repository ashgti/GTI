class UserMeta
  include DataMapper::Resource
  
  property :id, Serial

  class << self
    def storage_name repo
      'user_meta'
    end
  end
end
