require File.join( File.dirname(__FILE__), '..', "spec_helper" )

# Fixtures
Category.fix {{
  :name => /\w+/.gen
}}