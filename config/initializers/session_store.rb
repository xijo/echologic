# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_echoLogic_session',
  :secret      => 'e130611999f809cd7b0d4b66320fa8e58e66c438f5a528b506c5dc7d323c408cb81d000616342ddc10ae722e5075127e7024c29c2010b44391d0ca81e39d314a'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
