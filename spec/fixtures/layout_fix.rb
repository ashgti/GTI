require File.join( File.dirname(__FILE__), '..', "spec_helper" )

# Generic tag fixture
Layout.fix {{
  :name => /\w+/.gen,
  :body => /\w+/.gen
}}