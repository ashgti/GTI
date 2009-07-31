

GTI.config do 
  register '[[', ']]', Snippet
  register '[~', '~]', lambda do |id|
    "link_to content #{id}"
  end
  register '[*', '*]', lambda do |val|
    "value: #{val}"
  end
end
