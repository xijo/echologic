require 'rubygems'
require 'ezcrypto'
require 'json'
require 'cgi'
require 'base64'

class User < ActiveRecord::Base
  include UserExtension::Echo

  has_many :web_profiles, :dependent => :destroy
  has_many :memberships, :dependent => :destroy
  has_many :concernments, :dependent => :destroy
  has_many :tags, :through => :concernments

  has_many :reports, :foreign_key => 'suspect_id'


  named_scope :no_member, :conditions => { :memberships => nil }, :order => :email



  # Every user must have a profile. Profiles are destroyed with the user.
  has_one :profile, :dependent => :destroy

  # TODO add attr_accessible :active if needed.
  #attr_accessible :active

  # Authlogic plugin to do authentication
  acts_as_authentic do |c|
#    c.logged_in_timeout = 10.minutes#1.hour
    c.validates_length_of_password_field_options = {:on => :update, :minimum => 4, :if => :has_no_credentials?}
    c.validates_length_of_password_confirmation_field_options = {:on => :update, :minimum => 4, :if => :has_no_credentials?}
  end

  # acl9 plugin to do authorization
  acts_as_authorization_subject
  acts_as_authorization_object

  # we need to make sure that either a password or openid gets set
  # when the user activates his account
  def has_no_credentials?
    self.crypted_password.blank? && self.openid_identifier.blank?
  end

  # Return true if user is activated.
  def active?
    active
  end
  
  # handy interfacing
  def is_author?(other)
    other.author == self
  end

  # Signup process before activation: get login name and email, ensure to not
  # handle with sessions.
  def signup!(params)
    self.profile.first_name = params[:user][:profile][:first_name]
    self.profile.last_name  = params[:user][:profile][:last_name]
    self.email              = params[:user][:email]
    save_without_session_maintenance
  end

  # Returns the display name of the user
  # TODO Depricated. Use user.profile.full_name
  #  Changed for mailer model - anywhere else used?
  def display_name()
    self.profile.first_name + " " + self.profile.last_name;
  end

  # Activation process. Set user active and add its password and openID and
  # save with session handling afterwards.
  def activate!(params)
    self.active = true
    self.password = params[:user][:password]
    self.password_confirmation = params[:user][:password_confirmation]
    self.openid_identifier = params[:user][:openid_identifier]
    save
  end

  # Uses mailer to deliver activation instructions
  def deliver_activation_instructions!
    reset_perishable_token!
    Mailer.deliver_activation_instructions(self)
  end

  # Uses mailer to deliver activation confirmation
  def deliver_activation_confirmation!
    reset_perishable_token!
    Mailer.deliver_activation_confirmation(self)
  end

  # Send a password reset email through mailer
  def deliver_password_reset_instructions!
    reset_perishable_token!
    Mailer.deliver_password_reset_instructions(self)
  end

#  # Return user voice access link
#  def user_voice_link
#    options = {
#      :url    => "http://www.echologic.org/users",
#      :admin  => "deny",
#      :allow_forums => [31794],
#      :display_name => profile.full_name,
#      :guid   => id,
#      :email  => email,
#      :expires => (Time.now + 60*5).to_s
#    }
#
#    account_key = "echonomyjamtemporary"
#    api_key     = "8fa3e2a47017cff3dc8c28d8c461d699"
#
#    key = EzCrypto::Key.with_password account_key, api_key
#    encrypted = key.encrypt(options.to_json)
#    @data = Base64.encode64(encrypted).gsub(/\n/,'')
#    @data = CGI.escape(@data)
#
#    "http://www.temporary-discuss.echonomyJAM.org?sso=#{@data}"
#
#    # logout script:
#    # http://www.temporary-discuss.echonomyJAM.org/logout.json
#
#  end

end
