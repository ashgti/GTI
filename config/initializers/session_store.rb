# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_jumk_session',
  :secret      => '3268ae9caf9ef014229091c91a46086e4411d190c0e4a937a6750ff039a47e4039ce33cb92e8e29ff23668df06e6be3872386bb910b3b91672cd77f88a15356b'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
