require File.join(File.dirname(__FILE__), '..', 'spec_helper.rb')
include DataMapper::Sweatshop::Unique

# User fixtures
User.fix {{
  :login => unique { || /\w+/.gen },
  :email => unique { |x| /\w+\-#{x}\@\w+(\.com|\.net|\.edu|\.co.uk)/.gen.downcase },
  :login => /\w+/.gen,
  :email => /\w+\@\w+(\.com|\.net|\.edu|\.co.uk)/.gen.downcase,
  :password => 'password',
  :password_confirmation => 'password'
}}

User.fix(:random_password) {{
  :login => /\w+/.gen,
  :email => /\w+\@\w+(\.com|\.net|\.edu|\.co.uk)/.gen.downcase,
  :password => (password = /\w+/.gen),
  :password_confirmation => password
}}

User.fix(:admin) {{
  :login => 'admin',
  :email => 'ash@greaterthaninfinity.com',
  :password => 'password',
  :password_confirmation => 'password',
}}
