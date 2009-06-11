class Media < Post
  property :mime, String, :length => (1..100)
end