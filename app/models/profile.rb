class Profile < ActiveRecord::Base

  # Every profile has to belong to a user.
  belongs_to :user
  
  
  # There are two kind of people in the world..
  @@gender = {
    false => I18n.t('users.profile.gender.male'),
    true  => I18n.t('users.profile.gender.female')
  }
  
  # Access for the class variable
  def self.gender
    @@gender
  end
  
  # Returns the localized gender
  def localized_gender
    @@gender[female] || ''
  end
  
  # Handle attached user picture through paperclip plugin
  has_attached_file :avatar, :styles => { :small => "80x80>" },
                    :default_url => "/images/default_:style_avatar.png"
  validates_attachment_size :avatar, :less_than => 5.megabytes
  validates_attachment_content_type :avatar, :content_type => ['image/jpeg', 'image/png']
                    
  
  # Return the full name of the user consisting of pre- and surname
  def full_name
    "#{first_name} #{last_name}"
  end  
  
end
