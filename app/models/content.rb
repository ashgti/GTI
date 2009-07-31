unless defined? ImplementationError
  class ImplementationError < Exception
    # def initialize 
  end 
end

class Content
  include DataMapper::Resource

  ## Properties
  property :id,       Serial         
  property :title,    String,           :length => (5..50)        
  property :body,     Text,             :lazy => true
  property :type,     Discriminator
  property :deleted,  ParanoidBoolean
  property :mime,     String,           :length => (1..100)

  ## Validations
  validates_present :title
  
  ## Extras
  timestamps :at
  # is_versioned :on => :updated_at  # not working with STI
  
  ## Associations
  belongs_to :owner, :class_name => "User", :child_key => [:user_id]
  belongs_to :layout
  has n, :meta, :class_name => 'ContentMeta', :child_key => [:content_id]
  
  def process(request, response)
    raise ImplementationError, 'content doesn\'t know how to display itself, subclass and implement'
  end
end