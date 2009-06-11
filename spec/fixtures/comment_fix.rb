require File.join( File.dirname(__FILE__), '..', "spec_helper" )

# Fixtures
Comment.fix {{
  :by => /\w+/.gen.capitalize, 
  :user_ip => /\d{0,3}\.\d{0,3}\.\d{0,3}\.\d{0,3}/.gen,
  :content => (3..5).of { /[:paragraph:]/.gen }.join("\n\n"),
  :status => %w[published draft].pick
}}

# Example comment from a user, not anon
Comment.fix(:from_user) {{
  :user_ip => /\d{0,3}\.\d{0,3}\.\d{0,3}\.\d{0,3}/.gen,
  :content => (3..5).of { /[:paragraph:]/.gen }.join("\n\n"),
  :status => %w[published draft].pick
}}
