class Profile < ActiveRecord::Base

  # Every profile has to belong to a user.
  belongs_to :user,       :dependent => :destroy
  has_many :web_profiles, :through => :user
  has_many :memberships,  :through => :user
  has_many :concernments, :through => :user

  validates_presence_of :user_id


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
    @@gender[female] || I18n.t('application.general.undefined')
  end

  # Handle attached user picture through paperclip plugin
  has_attached_file :avatar, :styles => { :profile => "128x>", :header => "x45>" },
                    :default_url => "/images/default_:style_avatar.png"
  validates_attachment_size :avatar, :less_than => 1.megabytes
  validates_attachment_content_type :avatar, :content_type => ['image/jpeg', 'image/png']


  # Return the full name of the user composed of first- and lastname
  def full_name
    if (!first_name.blank? and !last_name.blank?)
      "#{first_name} #{last_name}"
    elsif !first_name.blank?
      first_name
    elsif !last_name.blank?
      last_name
    else
      I18n.t('application.general.undefined')
    end
  end
  
  # Return the formatted location of the user
  # TODO conditions in compact form?
  def location
    if not (country.blank? or city.blank?)
      "#{city}, #{country}"
    elsif not country.blank?
      country
    elsif not city.blank?
      city
    else
      I18n.t('application.general.undefined')
    end
  end

  # Return the first membership. If none is set return empty-string.
  def first_membership
    return "" if memberships.blank?
    "#{memberships.first.organisation} (#{memberships.first.position})"
  end

end
