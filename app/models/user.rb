class User < ActiveRecord::Base

  has_many :web_profiles
  has_many :memberships
  has_many :concernments
  has_many :tags, :through => :concernments

  # TODO add attr_accessible :active if needed.
  #attr_accessible :active
  
  # There are two kind of people in the world..
  @@gender = {
    0 => I18n.t('users.users.gender.male'),
    1 => I18n.t('users.users.gender.female')
  }
  
  # Access for the class variable
  def self.gender
    @@gender
  end
  
  # Return the localized gender.
  def human_gender
    @@gender[gender] || ''
  end

  # Authlogic plugin to do authentication
  acts_as_authentic do |c|
    c.validates_length_of_password_field_options = {:on => :update, :minimum => 4, :if => :has_no_credentials?}
    c.validates_length_of_password_confirmation_field_options = {:on => :update, :minimum => 4, :if => :has_no_credentials?}
  end

  # acl9 plugin to do authorization
  acts_as_authorization_subject
  acts_as_authorization_object

  # Handle attached user picture through paperclip plugin
  has_attached_file :picture, :styles => { :small => "80x80>" }#,
#                  :url  => "/assets/products/:id/:style/:basename.:extension",
#                  :path => ":rails_root/public/assets/products/:id/:style/:basename.:extension"

  validates_attachment_size :picture, :less_than => 5.megabytes
  validates_attachment_content_type :picture, :content_type => ['image/jpeg', 'image/png']


  # we need to make sure that either a password or openid gets set
  # when the user activates his account
  def has_no_credentials?
    self.crypted_password.blank? && self.openid_identifier.blank?
  end

  # Return true if user is activated.
  def active?
    active
  end

  # Signup process before activation: get login name and email, ensure to not
  # handle with sessions.
  def signup!(params)
    self.name    = params[:user][:name]
    self.prename = params[:user][:prename]
    self.email   = params[:user][:email]
    save_without_session_maintenance
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

  # Return the full name of the user consisting of pre- and surname
  def full_name
    "#{first_name} #{last_name}"
  end

end
