# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_collection_session',
  :secret      => '071b46139d97644ee84ce74da29ea4dc83a40f892ed5a0280539dd57ad548f42cf2087e761f625a9179c152840e9b1a17a73ce1cab59ec9d2cfe40aac2af26f6'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
