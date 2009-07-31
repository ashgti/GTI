require File.join(File.dirname(__FILE__), '..', 'spec_helper.rb')

## Post fixture
Page.fix {{
  :title => /\w+/.gen.capitalize, 
  :slug => /\w+/.gen,
  :expert => /[:sentence:]/.gen,
  :body => (3..5).of { /[:paragraph:]/.gen }.join("\n\n"),
  :owner => User.first(:login => 'admin') || User.gen(:admin)
}}

Page.fix(:with_tags) {{
  :title => /\w+/.gen.capitalize,
  :slug => /\w+/.gen, 
  :expert => /[:sentence:]/.gen,
  :body => (3..5).of { /[:paragraph:]/.gen }.join("\n\n"),
  :owner => User.first(:login => 'admin') || User.gen(:admin),
  :tags => (1..10).of { Tag.gen }
}}
