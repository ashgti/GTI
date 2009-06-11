require File.join( File.dirname(__FILE__), '..', "spec_helper" )

# Generic tag fixture
Tag.fix {{
  :name => /\w+/.gen
}}