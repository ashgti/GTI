class Page < Content
  ## Properties
  property :status,       Enum[:published, :draft], :default => :draft
  property :slug,         Slug
  property :long_title,   String
  property :expert,       Text
  property :menu_index,   Integer
  property :hide_in_menu, Boolean
  property :root,         Boolean

  ## Validations
  validates_present   :slug
  validates_is_unique :slug
  
  ## Hooks
  before :valid? do
    self.slug = self.title unless self.slug
  end
  
  ## Extras
  
  ## Associations
  has 1, :parent, :class_name => "Page", :child_key => ['id']
  # has n, :tags
  belongs_to :layout
  
  def process(request, response)
    @request, @response = request, response
    
    content_type = self.mime.to_s.strip
    @response.headers['Content-Type'] = content_type unless content_type.empty?
    
    @response.body = self.render
    @response.status = self.response_code
  end
  
  def render
    body
  end

  def response_code
    200
  end  
end
