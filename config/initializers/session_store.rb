# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_autofocus_session',
  :secret      => '49fdb852b898cd5d047654b37301c28cb2507b7fb0e84ff5555f04baf0a2c0c13c4ddb642ad6966c942d8048c3bc52fff32fb6b7bc8972898e82dce869f574bd'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
