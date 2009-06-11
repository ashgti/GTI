class Post
  include DataMapper::Resource
  
  ## Properties
  property :id,         Serial,                   :serial => true
  property :title,      String,                   :length => (1..45)
  property :slug,       Slug
  property :expert,     Text,                     :lazy => [:index]
  property :body,       Text,                     :laze => [:show]
  property :type,       Discriminator
  property :deleted,    ParanoidBoolean
  property :status,     Enum[:published, :draft], :default => :draft
  property :user_id,    Integer,                  :key => true
  
  ## Validations
  validates_present :title, :slug
  validates_is_unique :slug

  ## Hooks
  
  ## Extras
  timestamps :at
  is_versioned :on => :updated_at
  
  ## Associations
  belongs_to :owner, :class_name => "User", :child_key => [:user_id]
  has n, :tags
  has n, :comments
  has n, :categories, :through => Resource # has_and_belongs_to_many
end
