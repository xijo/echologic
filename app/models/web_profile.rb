class WebProfile < ActiveRecord::Base

  belongs_to :user

  validates_presence_of :sort, :location, :user_id
  
  # Map the different sorts of web profiles to their database representation
  # value, translate them ..
  @@sorts = {
    0 => I18n.t('users.web_profiles.sorts.homepage'),
    1 => I18n.t('users.web_profiles.sorts.blog'),
    2 => I18n.t('users.web_profiles.sorts.twitter'),
    3 => I18n.t('users.web_profiles.sorts.xing')
  }
  
  # ..and make it available as class method.
  def self.sorts 
    @@sorts 
  end
  
  # Validate that sort is correct
  validates_inclusion_of :sort, :in => WebProfile.sorts
  
end
