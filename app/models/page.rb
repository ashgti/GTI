class Page < Post
  has 1, :parent, :class_name => "Page", :child_key => ['id']
end
